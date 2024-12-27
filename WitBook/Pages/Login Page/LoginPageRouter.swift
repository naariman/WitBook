//
//  LoginPageRouter.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class LoginPageRouter {

    private unowned let commonStore: CommonStore
    private weak var view: LoginPageViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> LoginPageViewInput {
        let viewController = LoginPageViewController()
        view = viewController

        let interactor = LoginPageInteractor(view: viewController)
        viewController.interactor = interactor
        viewController.router = self

        return viewController
    }
}

extension LoginPageRouter: LoginPageRouterInput {
    
    func routeToHomePage() {}
}
