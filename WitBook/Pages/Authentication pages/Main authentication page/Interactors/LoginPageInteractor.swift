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
    private let authenticationService = AuthenticationService()
    private var dataToSend = UserLoginData()
    
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
    
    func didChangeEmailText(_ text: String?) {
        dataToSend.email = text ?? ""
    }
    
    func didChangePasswordText(_ text: String?) {
        dataToSend.password = text ?? ""
    }

    func didTapTextFieldPasswordButton() {
        isPasswordTextFieldSecured.toggle()
        view.pass(isPasswordSecureTextEntry: isPasswordTextFieldSecured)
        let systemName = isPasswordTextFieldSecured ? "eye" : "eye.slash"
        if let _ = UIImage(systemName: systemName) {
            view.pass(passwordRightButtonSystemName: systemName)
        }
    }

    func didTapLoginButton() {
        Task {
            let result = await authenticationService.login(data: dataToSend)
            switch result {
            case .success(let response):
                try KeychainManager().save(response.access_token, for: .accessToken)
                try KeychainManager().save(response.refresh_token, for: .refreshToken)
                view.routeToTabBarPages(commonStore: commonStore)
            case .failure(let error):
                view.showErrorAlert(message: error.errorDescription)
            }
        }
    }

    func didTapNoAccountButton() {
        view.routeToRegistrationPage(commonStore: commonStore)
    }
}
