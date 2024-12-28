////
////  BaseAlertViewController.swift
////  WitBook
////
////  Created by rbkusser on 28.12.2024.
////
//
//import UIKit
//
//public class BaseAlertViewController: BaseViewController {
//
//    open override var baseModalTransitionStyle: UIModalTransitionStyle { .crossDissolve }
//
//    public override var preferredStatusBarStyle: UIStatusBarStyle { .lightContent }
//
//    private let alertView = BaseAlertView()
//    
//    public override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(alertView)
//        setLayoutConstraints()
//        view.backgroundColor = BaseColor.dim
//        setActions()
//    }
//
//    private func setLayoutConstraints() {
//        alertView.translatesAutoresizingMaskIntoConstraints = false
//        let layoutConstraints = [
//            alertView.widthAnchor.constraint(equalToConstant: 295),
//            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            alertView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 60),
//            alertView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 60)
//        ]
//        NSLayoutConstraint.activate(layoutConstraints)
//    }
//
//    private func setActions() {
//        alertView.tapHandler = { [weak self] action in
//            guard let alertController = self else { return }
//            alertController.view.isUserInteractionEnabled = false
//            if action.isLoadingEnabled {
//                action.closure()
//            } else {
//                UIView.animate(withDuration: 0.4, delay: 0, options: .curveEaseInOut, animations: {
//                    alertController.dismiss(animated: true, completion: action.closure)
//                })
//            }
//        }
//    }
//    
//    public func set(image: UIImage? = nil, title: String? = nil, message: String, actions: [BaseAlertAction]) {
//        alertView.set(image: image, title: title, message: message, actions: actions)
//    }
//    
//    public func set(
//        image: UIImage? = nil,
//        title: String? = nil,
//        message: String,
//        yesAction: BaseAlertAction,
//        noAction: BaseAlertAction
//    ) {
//        alertView.set(image: image, title: title, message: message, yesAction: yesAction, noAction: noAction)
//    }
//}
