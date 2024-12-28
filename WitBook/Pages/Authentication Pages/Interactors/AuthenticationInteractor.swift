//
//  AuthenticationInteractor.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//

import Foundation

protocol AuhtenticationInteractorInput {
    
    func viewDidLoad()
    func didChangeEmailText(_ text: String?)
    func didChangePasswordText(_ text: String?)
    func didTapPasswordRightButton()
    func didTapLoginButton()
}

protocol AuthenticationInteractorProtocol: AuhtenticationInteractorInput {

    init(
        view: AuthenticationPagesViewInput,
        commonStore: CommonStore
    )
    
    var view: AuthenticationPagesViewInput { get }
    var isPasswordTextFieldSecured: Bool { get set }
}

extension AuthenticationInteractorProtocol {
    
}
