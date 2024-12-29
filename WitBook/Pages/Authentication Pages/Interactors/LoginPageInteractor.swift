//
//  LoginPageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginPageInteractor {

    unowned let view: AuthenticationPagesViewInput
    unowned let commonStore: CommonStore
    
    var isPasswordTextFieldSecured: Bool = true

    required init(
        view: AuthenticationPagesViewInput,
        commonStore: CommonStore
    ) {
        self.view = view
        self.commonStore = commonStore
    }
}

extension LoginPageInteractor: AuthenticationInteractorProtocol {
    
    func viewDidLoad() {
        view.pass(passwordRightButtonSystemName: "eye")
        view.pass(title: "login.title".localized)
        view.pass(emailPlaceholder: "login.email_placeholder".localized)
        view.pass(passwordPlaceholder: "login.password_placeholder".localized)
        view.pass(primaryButtonTitle: "login.button.title".localized)
        view.pass(isNoAccountButtonHidden: false)
    }
    
    func didChangeEmailText(_ text: String?) {}
    
    func didChangePasswordText(_ text: String?) {}
    
    func didTapPasswordRightButton() {
        isPasswordTextFieldSecured.toggle()
        let systemName = isPasswordTextFieldSecured ? "eye" : "eye.slash"
        if let _ = UIImage(systemName: systemName) {
            view.pass(passwordRightButtonSystemName: systemName)
            view.pass(isPasswordSecureTextEntry: isPasswordTextFieldSecured)
        }
    }
    
    func didTapLoginButton() {}
    
    func didTapNoAccountButton() {
        view.routeToRegistrationPage(commonStore: commonStore)
    }
}
