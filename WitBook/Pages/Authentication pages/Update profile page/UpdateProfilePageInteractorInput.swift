//
//  UpdateProfilePageInteractorInput.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol UpdateProfilePageInteractorInput: AnyObject {

    func didChangeNameText(_ text: String?)
    func didTapContinueButton()
}