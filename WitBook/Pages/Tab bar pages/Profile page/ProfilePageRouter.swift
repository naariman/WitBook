//
//  ProfilePageRouter.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class ProfilePageRouter {

    private unowned let commonStore: CommonStore
    private weak var view: ProfilePageViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> ProfilePageViewInput {
        let viewController = ProfilePageViewController()
        view = viewController

        let interactor = ProfilePageInteractor(view: viewController)
        viewController.interactor = interactor
        viewController.router = self

        return viewController
    }
}

extension ProfilePageRouter: ProfilePageRouterInput {

}
