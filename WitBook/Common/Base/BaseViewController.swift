//
//  BaseViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import UIKit

protocol BaseViewControllerProtocol where Self: UIViewController {

}

extension BaseViewControllerProtocol {
    
    func pass(navigationTitle: String) {
        navigationController?.title = navigationTitle
    }
    
    func showAlert(
        image: UIImage? = BaseImage.ic_bell.uiImage?.withTintColor(BaseColor.primary400 ?? .black),
        title: String? = "alert.title".localized,
        message: String?,
        buttonTitle: String? = "common.ok".localized
    ) {
        let viewController = BaseAlertViewController()
        viewController.set(image: image, title: title, message: message, buttonTitle: buttonTitle)
        present(alertController: viewController)
    }
    
    func showErrorAlert(
        image: UIImage? = BaseImage.ic_bell.uiImage?.withTintColor(BaseColor.error ?? .black),
        title: String? = "alert.title".localized,
        message: String?,
        buttonTitle: String? = "common.ok".localized
    ) {
        let viewController = BaseAlertViewController()
        viewController.set(image: image, title: title, message: message, buttonTitle: buttonTitle)
        viewController.set(titleLabelTextColor: BaseColor.error ?? .black)
        present(alertController: viewController)
    }
    
    
    
    private func present(alertController: BaseAlertViewController) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { [weak self] in
            alertController.modalPresentationStyle = .overFullScreen
            self?.present(alertController, animated: true)
        })
    }
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    var baseModalPresentationStyle: UIModalPresentationStyle { .overFullScreen }
    var baseModalTransitionStyle: UIModalTransitionStyle { modalTransitionStyle }
}
