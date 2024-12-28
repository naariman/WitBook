//
//  DashboardPageViewController.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class DashboardPageViewController: BaseViewController {

    var interactor: DashboardPageInteractorInput?
    var router: DashboardPageRouterInput?

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

extension DashboardPageViewController: DashboardPageViewInput {

}
