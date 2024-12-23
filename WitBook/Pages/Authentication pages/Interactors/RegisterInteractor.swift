//
//  RegisterInteractor.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

class RegisterInteractor: AuthenticationInteractorProtocol {

    unowned let view: AuthenticationViewInput

    required init(view: AuthenticationViewInput) {
        self.view = view
    }

    func setItems() {
        
    }
}
