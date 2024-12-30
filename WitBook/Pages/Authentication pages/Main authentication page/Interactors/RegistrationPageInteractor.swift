//
//  RegistrationPageInteractor.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//

import Foundation

class RegistrationPageInteractor {

    unowned let view: AuthenticationPagesViewInput
    unowned let commonStore: CommonStore
    private let networkService = AuthenticationService()
    private var dataToSend = UserRegistrationData()
    
    var isPasswordTextFieldSecured: Bool = true

    required init(
        view: AuthenticationPagesViewInput,
        commonStore: CommonStore
    ) {
        self.view = view
        self.commonStore = commonStore
    }
}

extension RegistrationPageInteractor: AuthenticationInteractorProtocol {
    
    func viewDidLoad() {
        view.pass(passwordRightButtonSystemName: "eye")
        view.pass(title: "registration.title".localized)
        view.pass(emailPlaceholder: "rigistration.email_placeholder".localized)
        view.pass(passwordPlaceholder: "registration.password_placeholder".localized)
        view.pass(primaryButtonTitle: "registration.button.title".localized)
    }
    
    func didChangeEmailText(_ text: String?) {
        dataToSend.email = text ?? ""
    }
    
    func didChangePasswordText(_ text: String?) {
        dataToSend.password = text ?? ""
    }
    
    func didTapRegisterButton() {
        Task {
            let result = await networkService.register(data: dataToSend)
            switch result {
            case  .success(let response):
                try KeychainManager().save(response.access_token, for: .accessToken)
                try KeychainManager().save(response.refresh_token, for: .refreshToken)

                view.routeToUpdateProfilePage(commonStore: commonStore)
            case .failure(let error):
                DispatchQueue.main.async { [weak self] in
                    self?.view.showErrorAlert(message: error.localizedDescription)
                }
            }
        }
    }
}
