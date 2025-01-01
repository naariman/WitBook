//
//  UpdateProfilePageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class UpdateProfilePageInteractor {

    private unowned let view: UpdateProfilePageViewInput
    
    private var dataToSend = UserUpdateData()
    private unowned let commonStore: CommonStore

    init(
        view: UpdateProfilePageViewInput,
        commonStore: CommonStore
    ) {
        self.view = view
        self.commonStore = commonStore
    }
}

extension UpdateProfilePageInteractor: UpdateProfilePageInteractorInput, HTTPClient {
    
    func didChangeNameText(_ text: String?) {
        dataToSend.username = text
    }
    
    func pass(_ image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.3) {
            dataToSend.avatar = data
        }
    }
    
    func didTapContinueButton() {
        let endpoint = ProfileEndpoints.updateProfile(body: dataToSend.fields)
        let multipartData = dataToSend.toMultipartData()
        
        sendMultipartRequest(
            endpoint: endpoint,
            multipartData: multipartData
        ) { [weak self] (result: Result<EmptyResponse, NetworkError>) in
            guard let self else { return }
            
            switch result {
            case .success:
                view.routeToTabBarPages(commonStore: commonStore)
            case .failure(let error):
                view.showErrorAlert(message: error.errorDescription)
                
            }
        }
    }
}
