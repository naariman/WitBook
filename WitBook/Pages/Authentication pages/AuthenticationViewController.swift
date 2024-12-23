//
//  AuthenticationViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AuthenticationViewController: BaseViewController {

    var interactor: AuthenticationInteractorInput?
    var router: AuthenticationRouterInput?

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let continueButton = BaseButton()

    private var items: [AuthenticationItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()

        interactor?.setItems()
    }

    private func addSubviews() {
        view.addSubviews(tableView, continueButton)
    }

    private func setLayoutConstraints() {
    	var layoutConstraints = [NSLayoutConstraint]()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: continueButton.bottomAnchor)
        ]

        continueButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor)
        ]

    	NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {

    }

    private func setActions() {
        tableView.delegate = self
        tableView.dataSource = self
        continueButton.addTarget(
            self,
            action: #selector(didTapContinueButton),
            for: .touchUpInside
        )
    }

    @objc
    private func didTapContinueButton() {
        interactor?.didTapContinueButton()
    }
}

extension AuthenticationViewController: AuthenticationViewInput {

    func pass(items: [AuthenticationItem]) {
        self.items = items
        tableView.reloadData()
    }

    func routeToDashboard() {
        router?.routeToDashboard()
    }
}

extension AuthenticationViewController: UITableViewDataSource,
                                        UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
