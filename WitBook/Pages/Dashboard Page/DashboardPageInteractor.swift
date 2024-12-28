//
//  DashboardPageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class DashboardPageInteractor {

    private unowned let view: DashboardPageViewInput

    init(view: DashboardPageViewInput) {
        self.view = view
    }
}

extension DashboardPageInteractor: DashboardPageInteractorInput {

}
