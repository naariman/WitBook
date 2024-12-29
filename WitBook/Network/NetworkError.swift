//
//  NetworkError.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 12.12.2024.
//

import Foundation

enum NetworkError: Error {

    case invalidURL
    case encode
    case decode
    case noResponse
    case unauthorized
    case unexpectedStatusCode
    case custom(message: String)
    case unknown

    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "The provided URL is invalid."
        case .encode:
            return "Failed to encode the request body."
        case .decode:
            return "Failed to decode the response."
        case .noResponse:
            return "No response received from the server."
        case .unauthorized:
            return "Unauthorized access. Please log in again."
        case .unexpectedStatusCode:
            return "An unexpected error occurred. Please try again."
        case .custom(let message):
            return message
        case .unknown:
            return "An unknown error occurred. Please try again."
        }
    }
}
