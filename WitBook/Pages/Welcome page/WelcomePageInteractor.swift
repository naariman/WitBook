//
//  WelcomePageInteractor.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class WelcomePageInteractor {

    private unowned let view: WelcomePageViewInput

    init(view: WelcomePageViewInput) {
        self.view = view
    }
}

extension WelcomePageInteractor: WelcomePageInteractorInput {

}
