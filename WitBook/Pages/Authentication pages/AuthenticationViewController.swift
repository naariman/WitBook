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

    private let navigationBar = BaseNavigationBar()
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
            continueButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -48),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ]

    	NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        view.backgroundColor = .white
    }

    private func setActions() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BaseContentCell<UILabel>.self)
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

    func pass(buttonTitle: String) {
        continueButton.title = buttonTitle
    }

    func routeToDashboard() {
        router?.routeToDashboard()
    }
}

extension AuthenticationViewController: UITableViewDataSource,
                                        UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = items[indexPath.row]

        switch item.id {
        case .titleLabel:
            let cell: BaseContentCell<UILabel> = tableView.dequeueReusableCell(for: indexPath)
            cell.view.text = item.title
            cell.view.font = .medium20
            cell.view.textColor = BaseColor.primary400
            cell.setMargin(top: 48)
            cell.setMargin(left: 16)
            return cell

        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}
