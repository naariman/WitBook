//
//  ProfilePageViewController.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class ProfilePageViewController: BaseViewController {

    var interactor: ProfilePageInteractorInput?
    var router: ProfilePageRouterInput?

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()
    }

    private func addSubviews() {

    }

    private func setLayoutConstraints() {
    	var layoutConstraints = [NSLayoutConstraint]()

    	layoutConstraints += [
    	]

    	NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {

    }

    private func setActions() {

    }
}

extension ProfilePageViewController: ProfilePageViewInput {

}
