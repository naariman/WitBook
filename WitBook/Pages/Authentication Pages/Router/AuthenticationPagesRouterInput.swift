//
//  AuthenticationPagesRouterInput.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol AuthenticationPagesRouterInput: AnyObject {
    
    func routeToDashboard(commonStore: CommonStore)
    func routeToRegistration(commonStore: CommonStore)
}