//
//  LoginPageViewInput.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginPageViewInput: BaseViewInput {
    
    func pass(passwordRightButtonImage: UIImage)
    func pass(isPasswordSecureTextEntry: Bool)
}
