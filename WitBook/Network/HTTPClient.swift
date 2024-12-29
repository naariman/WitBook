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
        responseModel: T.Type
    ) async -> Result<T, NetworkError>
}

extension HTTPClient {

    func sendRequest<T: Decodable>(
        endpoint: NetworkEndpoint,
        responseModel: T.Type
    ) async -> Result<T, NetworkError> {
        guard let url = URL(string: endpoint.url) else {
            return .failure(.invalidURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        if let body = endpoint.body {
            do {
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = try JSONEncoder().encode(body)
            } catch {
                return .failure(.encode)
            }
        }

        NetworkLogger.logRequest(request)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            
            NetworkLogger.logResponse(response, data: data, error: nil)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                do {
                    let decodedResponse = try JSONDecoder().decode(responseModel, from: data)
                    return .success(decodedResponse)
                } catch {
                    return .failure(.decode)
                }
            case 400...499:
                if let errorMessage = extractErrorMessage(from: data) {
                    return .failure(.custom(message: errorMessage))
                } else {
                    return .failure(.unexpectedStatusCode)
                }
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            NetworkLogger.logResponse(nil, data: nil, error: error)
            return .failure(.unknown)
        }
    }
    
    private func extractErrorMessage(from data: Data) -> String? {
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                return json["details"] as? String ?? json["error"] as? String
            }
        } catch {
            return nil
        }
        return nil
    }
    
    private func refreshTokens() async -> Result<UserTokensData, NetworkError> {
        guard let refreshToken = try? KeychainManager().getValue(for: .refreshToken) else {
            return .failure(.unauthorized)
        }
        let refreshEndpoint = AuthenticationEndpoint.refresh(body: ["refresh_token": refreshToken])
        return await sendRequest(endpoint: refreshEndpoint, responseModel: UserTokensData.self)
    }
}
