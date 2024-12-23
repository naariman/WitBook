//
//  AuthenticationInteractor.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class AuthenticationInteractor {

    private unowned let view: AuthenticationViewInput

    init(view: AuthenticationViewInput) {
        self.view = view
    }
}

extension AuthenticationInteractor: AuthenticationInteractorInput {

    func setItems() {}

    func didTapContinueButton() {}
}
