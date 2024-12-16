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
                return .failure(.unauthorized)
            default:
                return .failure(.unexpectedStatusCode)
            }
        } catch {
            return .failure(.unknown)
        }
    }
}
