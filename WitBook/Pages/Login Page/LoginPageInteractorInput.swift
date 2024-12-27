//
//  LoginPageInteractorInput.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol LoginPageInteractorInput: AnyObject {
    
    func viewDidLoad()
    func didChangeEmailText(_ text: String?)
    func didChangePasswordText(_ text: String?)
    func didTapPasswordRightButton()
    func didTapLoginButton()
}
