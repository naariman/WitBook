//
//  LoginInteractor.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

class LoginInteractor: AuthenticationInteractorProtocol {

    unowned let view: AuthenticationViewInput

    required init(view: AuthenticationViewInput) {
        self.view = view
    }

    func setItems() {
        let items = [
            AuthenticationItem(title: "login.title".localized()),
            AuthenticationItem(placeholder: "login.email_placeholder".localized()),
            AuthenticationItem(placeholder: "login.email_placeholder".localized())
        ]

        view.pass(items: items)
    }
}
