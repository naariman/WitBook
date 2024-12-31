//
//  UpdateProfilePageRouterInput.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

protocol UpdateProfilePageRouterInput: AnyObject {

    func routeToDashbord(commonStore: CommonStore)
    func presentPhotoPickerSourceOptionsBottomSheet()
}
