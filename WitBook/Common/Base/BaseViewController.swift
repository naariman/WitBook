//
//  BaseViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import UIKit

protocol BaseViewControllerProtocol where Self: UIViewController {}

extension BaseViewControllerProtocol {
    
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
    
    
    
    func push(viewController: UIViewController, animated: Bool = true) {
        let backButtonView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        let backButtonImage = UIImageView(image: BaseImage.ic_back.uiImage?.withRenderingMode(.alwaysOriginal))
        backButtonImage.contentMode = .scaleAspectFit
        backButtonImage.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backButtonView.addSubview(backButtonImage)
        
        backButtonView.frame.size.width = backButtonImage.frame.width + 16
        
        let backBarButtonItem = UIBarButtonItem(customView: backButtonView)
        
        navigationItem.backBarButtonItem = backBarButtonItem
        
        navigationController?.pushViewController(viewController, animated: animated)
    }
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    var baseModalPresentationStyle: UIModalPresentationStyle { .overFullScreen }
    var baseModalTransitionStyle: UIModalTransitionStyle { modalTransitionStyle }
}
