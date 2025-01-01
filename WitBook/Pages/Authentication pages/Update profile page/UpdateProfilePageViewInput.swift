//
//  UpdateProfilePageViewInput.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol UpdateProfilePageViewInput: BaseViewInput {
    
    func didSelectPickerSource(
        _ picker: PhotoSourcePickerViewController,
        didSelect source: UIImagePickerController.SourceType
    )
    func routeToTabBarPages(commonStore: CommonStore)
}
