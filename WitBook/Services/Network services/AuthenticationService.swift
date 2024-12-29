//
//  AuthenticationService.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

protocol AuthenticationServiceProtocol: HTTPClient {
    
    func login(data: UserLoginData) async -> Result<UserTokensData, NetworkError>
    func register(data: UserRegistrationData) async -> Result<UserTokensData, NetworkError>
}

class AuthenticationService: AuthenticationServiceProtocol {

    func login(data: UserLoginData) async -> Result<UserTokensData, NetworkError> {
        let endpoint = AuthenticationEndpoint.login(body: data)
        return await sendRequest(endpoint: endpoint, responseModel: UserTokensData.self)
    }
    
    func register(data: UserRegistrationData) async -> Result<UserTokensData, NetworkError> {
        let endpoint = AuthenticationEndpoint.register(body: data)
        return await sendRequest(endpoint: endpoint, responseModel: UserTokensData.self)
    }
}
