//
//  AuthenticationEndpoint.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 16.12.2024.
//

import Foundation

enum AuthenticationEndpoint: NetworkEndpoint {

    case register(body: Encodable)
    case login(body: Encodable)
    case refresh(body: Encodable)

    var serverUrl: String {
        return "http://127.0.0.1:8000/"
    }

    var apiUrl: String {
        switch self {
        case .register:
            return "users/register/"
        case .login:
            return "users/login/"
        case .refresh:
            return "users/refresh/"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .register, .login, .refresh:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .login(body: let body),
             .register(body: let body),
             .refresh(body: let body):
            return body
        }
    }

    var header: [String: String]? {
        switch self {
        default: nil
        }
    }
}
