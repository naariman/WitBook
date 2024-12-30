//
//  ProfilePageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class ProfilePageInteractor {

    private unowned let view: ProfilePageViewInput

    init(view: ProfilePageViewInput) {
        self.view = view
    }
}

extension ProfilePageInteractor: ProfilePageInteractorInput {

}
