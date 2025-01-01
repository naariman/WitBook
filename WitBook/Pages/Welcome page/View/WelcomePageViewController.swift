//
//  WelcomePageViewController.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class WelcomePageViewController: BaseViewController {

    var interactor: WelcomePageInteractorInput?
    var router: WelcomePageRouterInput?

    private let containerContentView = UIView()
    private let contentTitleLabel = UILabel()
    private let contentStackView = UIStackView()
    
    private let continueButton = BaseButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()
    }

    private func addSubviews() {
        view.addSubviews(
            containerContentView,
            continueButton
        )

        containerContentView.addSubviews(
            contentTitleLabel,
            contentStackView
        )
    }

    private func setLayoutConstraints() {
    	var layoutConstraints = [NSLayoutConstraint]()

        containerContentView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            containerContentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 124),
            containerContentView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            containerContentView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
        ]

        contentTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            contentTitleLabel.topAnchor.constraint(equalTo: containerContentView.topAnchor, constant: 16),
            contentTitleLabel.leftAnchor.constraint(equalTo: containerContentView.leftAnchor, constant: 16),
            contentTitleLabel.rightAnchor.constraint(equalTo: containerContentView.rightAnchor, constant: -16)
        ]

        contentStackView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            contentStackView.topAnchor.constraint(equalTo: contentTitleLabel.bottomAnchor, constant: 16),
            contentStackView.leftAnchor.constraint(equalTo: containerContentView.leftAnchor, constant: 16),
            contentStackView.rightAnchor.constraint(equalTo: containerContentView.rightAnchor, constant: -16),
            contentStackView.bottomAnchor.constraint(equalTo: containerContentView.bottomAnchor, constant: -32)
        ]

        continueButton.translatesAutoresizingMaskIntoConstraints = false
    	layoutConstraints += [
            continueButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -48),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
    	]

    	NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        view.backgroundColor = .white

        containerContentView.backgroundColor = .white
        containerContentView.layer.cornerRadius = 8
        containerContentView.layer.shadowColor = UIColor.black.cgColor.copy(alpha: 0.5)
        containerContentView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerContentView.layer.shadowOpacity = 0.5

        contentTitleLabel.text = "common.application.name".localized
        contentTitleLabel.font = .semibold32
        contentTitleLabel.textAlignment = .left
        contentTitleLabel.textColor = BaseColor.primary400

        contentStackView.axis = .vertical

        continueButton.title = "welcome.button.title".localized
    }

    private func setActions() {
        continueButton.addTarget(
            self,
            action: #selector(didTapContinueButton),
            for: .touchUpInside
        )

        let containerContentTexts = [
            "welcome.content.option1".localized,
            "welcome.content.option2".localized,
            "welcome.content.option3".localized,
            "welcome.content.option4".localized,
            "welcome.content.option5".localized,
            "welcome.content.option6".localized,
            "welcome.content.option7".localized
        ]

        for (index, text) in containerContentTexts.enumerated() {
            let label = UILabel()
            let isLastTwoTexts = index >= 5
            label.font = .regular16
            label.text = text
            label.textColor = isLastTwoTexts ? BaseColor.secondary300 : BaseColor.secondary600
            contentStackView.addArrangedSubview(label)
        }
    }

    @objc
    private func didTapContinueButton() {
        router?.routeToLoginPage()
    }

}

extension WelcomePageViewController: WelcomePageViewInput {}
