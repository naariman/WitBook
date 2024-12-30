//
//  UpdateProfilePageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

class UpdateProfilePageInteractor {

    private unowned let view: UpdateProfilePageViewInput

    init(view: UpdateProfilePageViewInput) {
        self.view = view
    }
}

extension UpdateProfilePageInteractor: UpdateProfilePageInteractorInput {
    
    func didChangeNameText(_ text: String?) {}
    func didTapContinueButton() {}
}
