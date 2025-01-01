//
//  HTTPClient.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 12.12.2024.
//

import Foundation

protocol HTTPClient {

    func sendRequest<T: Decodable>(
        endpoint: NetworkEndpoint,
        ignoreResponse: Bool,
        _ completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

extension HTTPClient {
    
    func sendRequest<T: Decodable>(
        endpoint: NetworkEndpoint,
        ignoreResponse: Bool = false,
        _ completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: endpoint.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                completion(.failure(.encode))
            }
        }
        
        NetworkLogger.logRequest(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.logResponse(response, data: data, error: error)
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.noResponse))
                }
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let data else { return }
                do {
                    if ignoreResponse {
                        DispatchQueue.main.async {
                            completion(.success(EmptyResponse() as! T))
                        }
                    } else {
                        let decodedData = try JSONDecoder().decode(T.self, from: data)
                        DispatchQueue.main.async {
                            completion(.success(decodedData))
                        }
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decode))
                    }
                }
            case 401:
                refreshTokens { result in
                    switch result {
                    case .success(let newTokens):
                        try? KeychainManager().save(newTokens.access_token, for: .accessToken)
                        try? KeychainManager().save(newTokens.refresh_token, for: .refreshToken)
                        
                        self.sendRequest(endpoint: endpoint, ignoreResponse: ignoreResponse, completion)
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case 400...499:
                if let errorMessage = extractErrorMessage(from: data) {
                    DispatchQueue.main.async {
                        completion(.failure(.custom(message: errorMessage)))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.unexpectedStatusCode))
                    }
                }
            default:
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }
    
    func sendMultipartRequest<T: Decodable>(
        endpoint: NetworkEndpoint,
        multipartData: MultipartData,
        _ completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: endpoint.url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var bodyData = Data()
        
        for (key, value) in multipartData.fields {
            bodyData.append("--\(boundary)\r\n")
            bodyData.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            bodyData.append("\(value)\r\n")
        }
        
        for file in multipartData.files {
            bodyData.append("--\(boundary)\r\n")
            bodyData.append("Content-Disposition: form-data; name=\"\(file.key)\"; filename=\"\(file.filename)\"\r\n")
            bodyData.append("Content-Type: \(file.mimeType)\r\n\r\n")
            bodyData.append(file.data)
            bodyData.append("\r\n")
        }

        bodyData.append("--\(boundary)--\r\n")
        request.httpBody = bodyData

        NetworkLogger.logRequest(request)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            NetworkLogger.logResponse(response, data: data, error: error)
            
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(.noResponse))
                }
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let data else { return }
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decodedData))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(.decode))
                    }
                }
            case 401:
                refreshTokens { result in
                    switch result {
                    case .success(let newTokens):
                        try? KeychainManager().save(newTokens.access_token, for: .accessToken)
                        try? KeychainManager().save(newTokens.refresh_token, for: .refreshToken)
                        
                        self.sendMultipartRequest(endpoint: endpoint, multipartData: multipartData, completion)
                    case .failure(let error):
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                }
            case 400...499:
                if let errorMessage = extractErrorMessage(from: data) {
                    DispatchQueue.main.async {
                        completion(.failure(.custom(message: errorMessage)))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(.failure(.unexpectedStatusCode))
                    }
                }
            default:
                DispatchQueue.main.async {
                    completion(.failure(.unknown))
                }
            }
        }.resume()
    }

    
    private func extractErrorMessage(from data: Data?) -> String? {
        guard let data else { return nil }
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json["details"] as? String ?? json["error"] as? String
            }
        } catch {
            return nil
        }
        return nil
    }
    
    private func refreshTokens(completion: @escaping (Result<UserTokensData, NetworkError>) -> Void) {
        guard let refreshToken = try? KeychainManager().getValue(for: .refreshToken) else {
            completion(.failure(.unauthorized))
            return
        }
        let refreshEndpoint = AuthenticationEndpoint.refresh(body: ["refresh_token": refreshToken])
        sendRequest(endpoint: refreshEndpoint) { (result: Result<UserTokensData, NetworkError>) in
            completion(result)
        }
    }
}
