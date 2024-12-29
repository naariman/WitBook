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
        request.log()
        
        if let body = endpoint.body {
            request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(
                for: request,
                delegate: nil
            )
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.noResponse)
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(
                    responseModel,
                    from: data
                ) else {
                    return .failure(.decode)
                }
                return .success(decodedResponse)
            case 401:
                let refreshTokensResult = await refreshTokens()
                
                switch refreshTokensResult {
                case .success(let tokens):
                    try? KeychainManager().save(tokens.access_token, for: .accessToken)
                    try? KeychainManager().save(tokens.refresh_token, for: .refreshToken)
                    
                    var updatedRequest = request
                    updatedRequest.setValue(
                        "Bearer \(tokens.access_token)",
                        forHTTPHeaderField: "Authorization"
                    )
                    let (retryData, retryResponse) = try await URLSession.shared.data(
                        for: updatedRequest,
                        delegate: nil
                    )
                    guard let retryResponse = retryResponse as? HTTPURLResponse else {
                        return .failure(.noResponse)
                    }
                    switch retryResponse.statusCode {
                    case 200...299:
                        guard let decodedRetryResponse = try? JSONDecoder().decode(
                            responseModel,
                            from: retryData
                        ) else {
                            return .failure(.decode)
                        }
                        return .success(decodedRetryResponse)
                    default:
                        return .failure(.unexpectedStatusCode)
                    }
                case .failure(let error):
                    return .failure(error)
                }
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
    
    private func refreshTokens() async -> Result<UserTokensData, NetworkError> {
        guard let refreshToken = try? KeychainManager().getValue(for: .refreshToken) else {
            return .failure(.unauthorized)
        }
        let refreshEndpoint = AuthenticationEndpoint.refresh(body: ["refresh_token": refreshToken])
        return await sendRequest(endpoint: refreshEndpoint, responseModel: UserTokensData.self)
    }
}
