//
//  AuthenticationViewInput.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol AuthenticationViewInput: BaseViewInput {

    func pass(items: [AuthenticationItem])
    func pass(buttonTitle: String)
    func routeToDashboard()
}
