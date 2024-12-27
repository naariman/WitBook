//
//  LoginPageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginPageInteractor {

    private unowned let view: LoginPageViewInput
    
    private var isPasswordSecured = true

    init(view: LoginPageViewInput) {
        self.view = view
    }
}

extension LoginPageInteractor: LoginPageInteractorInput {
    
    func viewDidLoad() {
        let systemName = isPasswordSecured ? "eye" : "eye.slash"
        if let image = UIImage(systemName: systemName) {
            view.pass(passwordRightButtonImage: image)
        }
    }

    func didChangeEmailText(_ text: String?) {
        
    }
    
    func didChangePasswordText(_ text: String?) {
        
    }
    
    func didTapPasswordRightButton() {
        isPasswordSecured.toggle()
        let systemName = isPasswordSecured ? "eye" : "eye.slash"
        if let image = UIImage(systemName: systemName) {
            view.pass(passwordRightButtonImage: image)
            view.pass(isPasswordSecureTextEntry: isPasswordSecured)
        }
    }
    

    func didTapLoginButton() {
        
    }
}
