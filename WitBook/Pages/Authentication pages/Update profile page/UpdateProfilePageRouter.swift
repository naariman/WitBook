//
//  UpdateProfilePageRouter.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class UpdateProfilePageRouter {

    private unowned let commonStore: CommonStore
    private weak var view: UpdateProfilePageViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> UpdateProfilePageViewInput {
        let viewController = UpdateProfilePageViewController()
        view = viewController

        let interactor = UpdateProfilePageInteractor(view: viewController)
        viewController.interactor = interactor
        viewController.router = self

        return viewController
    }
}

extension UpdateProfilePageRouter: UpdateProfilePageRouterInput {

    func routeToDashbord(commonStore: CommonStore) {
        let router = DashboardPageRouter(commonStore: commonStore)
        let viewController = router.compose()
        view?.present(viewController: viewController)
    }
}
