//
//  MainTabBarController.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private unowned var commonStore: CommonStore
    
    init(commonStore: CommonStore) {
        self.commonStore = commonStore
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dashboardViewController = DashboardPageRouter(commonStore: commonStore).compose()
        let profileViewController = ProfilePageRouter(commonStore: commonStore).compose()
        
        viewControllers = [
            dashboardViewController,
            profileViewController
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
