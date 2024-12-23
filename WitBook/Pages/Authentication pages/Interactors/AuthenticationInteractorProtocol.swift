//
//  AuthenticationInteractorProtocol.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

protocol AuthenticationInteractorProtocol: AuthenticationInteractorInput {

    init(
        view: AuthenticationViewInput
    )
}

extension AuthenticationInteractorProtocol {

    func setItems() {
        
    }

    func didTapContinueButton() {
        
    }
}
