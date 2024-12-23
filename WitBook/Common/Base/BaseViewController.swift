//
//  BaseViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import UIKit

class BaseViewController: UIViewController, BaseViewControllerProtocol {

    private func stylizeNavigationBar() {
        navigationController?.navigationBar.backIndicatorImage = BaseImage.ic_back.uiImage
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = BaseImage.ic_back.uiImage
    }
}
