//
//  AuthenticationPagesViewController.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class AuthenticationPagesViewController: BaseViewController {
    
    var interactor: AuthenticationInteractorProtocol?
    var router: AuthenticationPagesRouterInput?
    
    private let titleLabel = UILabel()
    private let emailTextField = BaseTextField()
    private let passwordTextField = BaseTextField()
    private let noAccountButton = UIButton()
    private let continueButton = BaseButton()
    
    private var continueButtonBottomConstraint = NSLayoutConstraint()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()
        
        interactor?.viewDidLoad()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addSubviews() {
        view.addSubviews(
            titleLabel,
            emailTextField,
            passwordTextField,
            noAccountButton,
            continueButton
        )
    }
    
    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ]
        
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ]
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 16),
            passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ]
        
        noAccountButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            noAccountButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            noAccountButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            noAccountButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            noAccountButton.heightAnchor.constraint(equalToConstant: 16)
        ]
        
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        continueButtonBottomConstraint = continueButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -48
        )
        layoutConstraints += [
            continueButtonBottomConstraint,
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private func stylize() {
        view.backgroundColor = .white
        
        titleLabel.textAlignment = .left
        titleLabel.textColor = BaseColor.primary400
        titleLabel.font = .medium20
        
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.isRightButtonHidden = false
        
        noAccountButton.setTitle("login.no_account".localized, for: .normal)
        noAccountButton.setTitleColor(BaseColor.link200, for: .normal)
        noAccountButton.titleLabel?.font = .regular14
        noAccountButton.titleLabel?.textColor = BaseColor.link200
        noAccountButton.contentHorizontalAlignment = .right
        noAccountButton.isHidden = true
    }
    
    private func setActions() {
        continueButton.addTarget(self, action: #selector(didTapContinueButton), for: .touchUpInside)
        noAccountButton.addTarget(self, action: #selector(didTapNoAccountButton), for: .touchUpInside)
        passwordTextField.rightButtonAction = { [weak self] in
            self?.interactor?.didTapPasswordRightButton()
        }
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
        emailTextField.addTarget(self, action: #selector(didChangeEmailTextField), for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(didChangePasswordTextField), for: .editingChanged)
    }
}

extension AuthenticationPagesViewController: AuthenticationPagesViewInput {
    
    func pass(title: String) {
        titleLabel.text = title
    }
    
    func pass(emailPlaceholder: String) {
        emailTextField.placeholderText = emailPlaceholder
    }
    
    func pass(passwordPlaceholder: String) {
        passwordTextField.placeholderText = passwordPlaceholder
    }
    
    func pass(passwordRightButtonSystemName: String) {
        passwordTextField.rightButtonImage = UIImage(systemName: passwordRightButtonSystemName)?.withTintColor(.black)
    }

    func pass(isPasswordSecureTextEntry: Bool) {
        passwordTextField.isSecureTextEntry = isPasswordSecureTextEntry
    }

    func pass(isNoAccountButtonHidden: Bool) {
        noAccountButton.isHidden = isNoAccountButtonHidden
    }
    
    func pass(primaryButtonTitle: String) {
        continueButton.title = primaryButtonTitle
    }
}

private extension AuthenticationPagesViewController {
    
    @objc func didTapContinueButton() {
        interactor?.didTapLoginButton()
    }

    @objc func didTapNoAccountButton() {
        router?.routeToRegistration(commonStore: .init())
    }
    
    @objc func didChangeEmailTextField() {
        interactor?.didChangeEmailText(emailTextField.text)
    }
    
    @objc func didChangePasswordTextField() {
        interactor?.didChangePasswordText(passwordTextField.text)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
              let keyboardRectangle = keyboardFrame.cgRectValue
              let keyboardHeight = keyboardRectangle.height
            continueButtonBottomConstraint.constant = -12 - keyboardHeight
            UIView.animate(withDuration: 0.25) { [weak self] in
                self?.view.layoutIfNeeded()
            }
          }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        continueButtonBottomConstraint.constant = -48
        UIView.animate(withDuration: 0.25) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
