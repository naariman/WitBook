//
//  BaseViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import UIKit

protocol BaseViewControllerProtocol where Self: UIViewController {
    
    func pass(navigationTitle: String)
}

extension BaseViewControllerProtocol {
    
    func pass(navigationTitle: String) {
        navigationController?.title = navigationTitle
    }
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {}
