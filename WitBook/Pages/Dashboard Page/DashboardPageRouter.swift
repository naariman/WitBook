//
//  DashboardPageRouter.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class DashboardPageRouter {

    private unowned let commonStore: CommonStore
    private weak var view: DashboardPageViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> DashboardPageViewInput {
        let viewController = DashboardPageViewController()
        view = viewController

        let interactor = DashboardPageInteractor(view: viewController)
        viewController.interactor = interactor
        viewController.router = self

        return viewController
    }
}

extension DashboardPageRouter: DashboardPageRouterInput {

}
