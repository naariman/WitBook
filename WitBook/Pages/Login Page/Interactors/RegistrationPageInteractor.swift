//
//  RegistrationPageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//

import Foundation

class RegistrationPageInteractor {

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

extension RegistrationPageInteractor: AuthenticationInteractorProtocol {
    
    func viewDidLoad() {
        view.pass(passwordRightButtonSystemName: "eye")
        view.pass(title: "registration.title".localized)
        view.pass(emailPlaceholder: "rigistration.email_placeholder".localized)
        view.pass(passwordPlaceholder: "registration.password_placeholder".localized)
        view.pass(primaryButtonTitle: "registration.button.title".localized)
    }
    
    func didChangeEmailText(_ text: String?) {}
    
    func didChangePasswordText(_ text: String?) {}
    
    func didTapPasswordRightButton() {}
    
    func didTapLoginButton() {}
}
