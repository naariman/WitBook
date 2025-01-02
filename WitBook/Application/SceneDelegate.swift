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
        refreshToken(window: window)
        window.makeKeyAndVisible()
    }
}

extension SceneDelegate: HTTPClient {
    
    func refreshToken(window: UIWindow) {
        refreshTokens { result in
            switch result {
            case .success(let newTokens):
                try? KeychainManager().save(newTokens.access_token, for: .accessToken)
                try? KeychainManager().save(newTokens.refresh_token, for: .refreshToken)
                
                let viewController = MainTabBarController(commonStore: self.commonStore)
                window.rootViewController = UINavigationController(rootViewController: viewController)
            case .failure:
                let router = WelcomePageRouter(commonStore: self.commonStore)
                let viewController = router.compose()
                window.rootViewController = UINavigationController(rootViewController: viewController)
            }
        }
    }
    
    private func refreshTokens(completion: @escaping (Result<UserTokensData, NetworkError>) -> Void) {
        guard let refreshToken = try? KeychainManager().getValue(for: .refreshToken) else {
            completion(.failure(.unauthorized))
            return
        }
        let refreshEndpoint = AuthenticationEndpoint.refresh(body: ["refresh_token": refreshToken])
        sendRequest(endpoint: refreshEndpoint) { (result: Result<UserTokensData, NetworkError>) in
            completion(result)
        }
    }
}

