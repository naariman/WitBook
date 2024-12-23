//
//  BaseViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import UIKit
import SafariServices

protocol BaseViewControllerProtocol where Self: UIViewController {

}

extension BaseViewControllerProtocol {

    func pass(navigationTitle: String) {
        navigationController?.title = navigationTitle
    }

    func push(
        _ viewController: UIViewController,
        removeCurrent: Bool = false,
        animated: Bool = true
    ) {
        defer {
            if removeCurrent,
               let controllers = navigationController?.viewControllers,
               let index = controllers.firstIndex(where: { $0 === self }) {
                navigationController?.viewControllers.remove(at: index)
            }
        }

        // Remove title from backBarButtonItem
        if let navigationController = self as? UINavigationController,
           let baseViewController = navigationController.visibleViewController as? BaseViewControllerProtocol {
            baseViewController.push(viewController, animated: animated)
            return
        }

        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = ""
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func push(
        _ viewController: UIViewController,
        removeControllersWithIndices indices: [Int],
        animated: Bool = true
    ) {
        defer {
            if let navigationController = navigationController {
                var controllers = navigationController.viewControllers
                let filteredIndices: [Int] = Array(Set(indices)).sorted().reversed()
                for index in filteredIndices where 0..<controllers.count ~= index {
                    controllers.remove(at: index)
                }
                navigationController.setViewControllers(controllers, animated: false)
            }
        }

        // Remove title from backBarButtonItem
        if let navigationController = self as? UINavigationController,
           let baseViewController = navigationController.visibleViewController as? BaseViewControllerProtocol {
            baseViewController.push(viewController, animated: animated)
            return
        }

        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = ""
        navigationItem.backBarButtonItem = backBarButtonItem
        navigationController?.pushViewController(viewController, animated: animated)
    }

    func pop(to viewController: UIViewController? = nil, animated: Bool = true) {
        guard let navigationController = navigationController else { return }
        if let viewController = viewController {
            navigationController.popToViewController(viewController, animated: animated)
        } else {
            if let index = navigationController.viewControllers.firstIndex(where: { $0 == self }), index > 0 {
                let viewController = navigationController.viewControllers[index - 1]
                navigationController.popToViewController(viewController, animated: animated)
            }
        }
    }

    func popToRoot(animated: Bool = true) {
        navigationController?.popToRootViewController(animated: animated)
    }

    /// Show web page
    /// - Parameter url: url of the web page
    func presentWebPage(with url: URL) {
        let sfSafariViewController = SFSafariViewController(url: url)
        present(sfSafariViewController, animated: true)
    }
}
