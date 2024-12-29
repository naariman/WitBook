//
//  AuthenticationPagesViewInput.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AuthenticationPagesViewInput: BaseViewInput {
    
    func pass(title: String)
    func pass(emailPlaceholder: String)
    func pass(passwordPlaceholder: String)
    func pass(passwordRightButtonSystemName: String)
    func pass(isPasswordSecureTextEntry: Bool)
    func pass(isNoAccountButtonHidden: Bool)
    func pass(primaryButtonTitle: String)
    func routeToRegistrationPage(commonStore: CommonStore)
}
