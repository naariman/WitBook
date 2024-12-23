//
//  AuthenticationRouter.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class AuthenticationRouter<Interactor: AuthenticationInteractorProtocol> {

    private unowned let commonStore: CommonStore
    private weak var view: AuthenticationViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> AuthenticationViewInput {
        let viewController = AuthenticationViewController()
        view = viewController

        let interactor = AuthenticationInteractor(view: viewController)
        viewController.interactor = interactor
        viewController.router = self

        return viewController
    }
}

extension AuthenticationRouter: AuthenticationRouterInput {

}
