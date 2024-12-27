//
//  LoginPageViewController.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class LoginPageViewController: BaseViewController {
    
    var interactor: LoginPageInteractorInput?
    var router: LoginPageRouterInput?
    
    private let titleLabel = UILabel()
    private let emailTextField = BaseTextField()
    private let passwordTextField = BaseTextField()
    private let noAccountButton = UIButton()
    private let loginButton = BaseButton()
    
    private var loginButtonBottomConstraint = NSLayoutConstraint()
    
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
            loginButton
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
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButtonBottomConstraint = loginButton.bottomAnchor.constraint(
            equalTo: view.bottomAnchor,
            constant: -48
        )
        layoutConstraints += [
            loginButtonBottomConstraint,
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private func stylize() {
        view.backgroundColor = .white
        
        titleLabel.text = "login.title".localized
        titleLabel.textAlignment = .left
        titleLabel.textColor = BaseColor.primary400
        titleLabel.font = .medium20
        
        emailTextField.placeholderText = "login.email_placeholder".localized
        emailTextField.keyboardType = .emailAddress
        
        passwordTextField.placeholderText = "login.password_placeholder".localized
        passwordTextField.isSecureTextEntry = true
        passwordTextField.isRightButtonHidden = false
        
        noAccountButton.setTitle("login.no_account".localized, for: .normal)
        noAccountButton.setTitleColor(BaseColor.link200, for: .normal)
        noAccountButton.titleLabel?.font = .regular14
        noAccountButton.titleLabel?.textColor = BaseColor.link200
        noAccountButton.contentHorizontalAlignment = .right
        
        loginButton.title = "login.button.title".localized
    }
    
    private func setActions() {
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
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

extension LoginPageViewController: LoginPageViewInput {

    func pass(passwordRightButtonImage: UIImage) {
        passwordTextField.rightButtonImage = passwordRightButtonImage.withTintColor(.black)
    }
    
    func pass(isPasswordSecureTextEntry: Bool) {
        passwordTextField.isSecureTextEntry = isPasswordSecureTextEntry
    }
}

private extension LoginPageViewController {
    
    @objc func didTapLoginButton() {
        interactor?.didTapLoginButton()
    }

    @objc func didTapNoAccountButton() {}
    
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
            loginButtonBottomConstraint.constant = -12 - keyboardHeight
            UIView.animate(withDuration: 0.3) { [weak self] in
                self?.view.layoutIfNeeded()
            }
          }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        loginButtonBottomConstraint.constant = -48
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.view.layoutIfNeeded()
        }
    }
}
