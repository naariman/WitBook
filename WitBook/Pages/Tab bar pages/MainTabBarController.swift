//
//  MainTabBarController.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//

import UIKit

class MainTabBarController: UITabBarController {

    private unowned var commonStore: CommonStore

    private var timerButton = UIButton()
    
    init(commonStore: CommonStore) {
        self.commonStore = commonStore
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let customTabBar = MainTabBar()
        self.setValue(customTabBar, forKey: "tabBar")
        
        addSubviews()
        setLayoutConstraints()
        stylize()
        setupViewControllers()
    }
    
    private func addSubviews() {
        tabBar.addSubview(timerButton)
    }

    private func setLayoutConstraints() {
        timerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timerButton.widthAnchor.constraint(equalToConstant: 56),
            timerButton.heightAnchor.constraint(equalToConstant: 56),
            timerButton.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            timerButton.centerYAnchor.constraint(equalTo: tabBar.topAnchor)
        ])
    }
    
    private func stylize() {
        timerButton.setBackgroundImage(BaseImage.ic_timer.uiImage, for: .normal)
        tabBar.tintColor = BaseColor.primary400
    }
    
    private func setupViewControllers() {
        let dashboardViewController = DashboardPageRouter(commonStore: commonStore).compose()
        dashboardViewController.tabBarItem = UITabBarItem(
            title: "dashboard.title".localized,
            image: BaseImage.ic_dashboard.uiImage?.withRenderingMode(.alwaysOriginal),
            selectedImage: BaseImage.ic_dashboard_selected.uiImage?.withRenderingMode(.alwaysOriginal)
        )
        
        let profileViewController =  ProfilePageRouter(commonStore: commonStore).compose()
        profileViewController.tabBarItem = UITabBarItem(
            title: "profile.title".localized,
            image: BaseImage.ic_profile.uiImage?.withRenderingMode(.alwaysOriginal),
            selectedImage: BaseImage.ic_profile.uiImage?.withTintColor(BaseColor.primary400!)
        )
        
        self.viewControllers = [dashboardViewController, profileViewController]
    }
    
    @objc func menuButtonAction(sender: UIButton) {}
}
