//
//  ProfileEndpoints.swift
//  WitBook
//
//  Created by rbkusser on 31.12.2024.
//

import Foundation

enum ProfileEndpoints: NetworkEndpoint {

    case updateProfile(body: Encodable)

    var serverUrl: String {
        return "https://witbook.ddns.net/"
    }

    var apiUrl: String {
        switch self {
        case .updateProfile:
            return "users/update_profile/"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .updateProfile:
            return .post
        }
    }

    var body: Encodable? {
        switch self {
        case .updateProfile(let body):
            return body
        }
    }

    var header: [String: String]? {
        switch self {
        default:
            do {
                let token = try KeychainManager().getValue(for: .accessToken)
                return ["Authorization": "Bearer \(token)"]
            } catch {
                return nil
            }
        }
    }
}
