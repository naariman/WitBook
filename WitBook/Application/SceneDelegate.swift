//  SceneDelegate.swift
//  ffqw
//
//  Created by Nariman Nogaibayev on 08.12.2024.
//

import UIKit

class SceneDelegate: UIResponder,
                     UIWindowSceneDelegate {

    var window: UIWindow?
    private let commonStore = CommonStore()

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let router = UpdateProfilePageRouter(commonStore: commonStore)
        let viewController = router.compose()
        window.rootViewController = UINavigationController(rootViewController: viewController)
        window.makeKeyAndVisible()
    }
}

