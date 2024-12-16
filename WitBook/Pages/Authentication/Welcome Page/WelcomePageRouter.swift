//
//  WelcomePageRouter.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class WelcomePageRouter {

    private unowned let commonStore: CommonStore
    private weak var view: WelcomePageViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> WelcomePageViewInput {
        let viewController = WelcomePageViewController()
        view = viewController

        let interactor = WelcomePageInteractor(view: viewController)
        viewController.interactor = interactor
        viewController.router = self

        return viewController
    }
}

extension WelcomePageRouter: WelcomePageRouterInput {

    func routeToLoginPage() {
        
    }
}
