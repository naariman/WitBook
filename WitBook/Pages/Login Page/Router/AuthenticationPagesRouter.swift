//
//  AuthenticationPagesRouter.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class AuthenticationPagesRouter<Interactor: AuthenticationInteractorProtocol> {

    private unowned let commonStore: CommonStore
    private weak var view: AuthenticationPagesViewInput?

    init(commonStore: CommonStore) {
        self.commonStore = commonStore
    }

    func compose() -> AuthenticationPagesViewInput {
        let viewController = AuthenticationPagesViewController()
        view = viewController
        
        viewController.interactor = Interactor(view: viewController, commonStore: .init())
        viewController.router = self

        return viewController
    }
}

extension AuthenticationPagesRouter: AuthenticationPagesRouterInput {
    func routeToDashboard(commonStore: CommonStore) {
//        let router = DashboardPageRouter(commonStore: commonStore)
//        let viewController = router.compose()
    }
    
    func routeToRegistration(commonStore: CommonStore) {
        let router = AuthenticationPagesRouter<RegistrationPageInteractor>(commonStore: .init())
        let viewController = router.compose()
        view?.navigationController?.pushViewController(viewController, animated: true)
    }
}
