//
//  BaseAlertViewController.swift
//  WitBook
//
//  Created by rbkusser on 28.12.2024.
//

import UIKit

class BaseAlertViewController: BaseViewController {
    
    override var modalTransitionStyle: UIModalTransitionStyle {
        get { return .crossDissolve }
        set { super.modalTransitionStyle = newValue }
    }

    private var action: (() -> Void)?
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    private let alertContentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let alertTopContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image?.withRenderingMode(.alwaysTemplate)
        return imageView
    }()
    
    private let alertCloseButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(BaseImage.ic_close.uiImage, for: .normal)
        return button
    }()
    
    private let alertTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .medium20
        label.textColor = BaseColor.primary400
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let alertMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .regular16
        label.textAlignment = .center
        label.textColor = BaseColor.secondary500
        label.numberOfLines = 0
        return label
    }()
    
    private let alertPrimaryButton: BaseButton = {
        let button = BaseButton()
        button.title = "alert.good".localized
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stylize()
        addSubviews()
        setLayoutConstraints()
        setActions()
    }
    
    private func stylize() {
        view.backgroundColor = BaseColor.dim
    }
    
    private func addSubviews() {
        view.addSubview(alertView)
        alertView.addSubview(alertContentStackView)
        
        alertTopContainerView.addSubview(alertImageView)
        alertTopContainerView.addSubview(alertCloseButton)
        
        alertContentStackView.addArrangedSubview(alertTopContainerView)
        alertContentStackView.addArrangedSubview(alertTitleLabel)
        alertContentStackView.addArrangedSubview(alertMessageLabel)
        alertContentStackView.addArrangedSubview(alertPrimaryButton)
    }
    
    private func setLayoutConstraints() {
        alertView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 60),
            alertView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -60),
            alertView.widthAnchor.constraint(equalToConstant: 320),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            alertContentStackView.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 24),
            alertContentStackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            alertContentStackView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor),
            alertContentStackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -24),
        
            alertTopContainerView.heightAnchor.constraint(equalToConstant: 24),
            alertTopContainerView.leadingAnchor.constraint(equalTo: alertContentStackView.leadingAnchor),
            alertTopContainerView.trailingAnchor.constraint(equalTo: alertContentStackView.trailingAnchor),
            
            alertImageView.centerXAnchor.constraint(equalTo: alertTopContainerView.centerXAnchor),
            alertImageView.centerYAnchor.constraint(equalTo: alertTopContainerView.centerYAnchor),
            alertImageView.heightAnchor.constraint(equalToConstant: 24),
            alertImageView.widthAnchor.constraint(equalToConstant: 24),
            
            alertCloseButton.trailingAnchor.constraint(equalTo: alertTopContainerView.trailingAnchor, constant: -16),
            alertCloseButton.centerYAnchor.constraint(equalTo: alertTopContainerView.centerYAnchor),
            alertCloseButton.heightAnchor.constraint(equalToConstant: 24),
            alertCloseButton.widthAnchor.constraint(equalToConstant: 24),
            
            alertPrimaryButton.leadingAnchor.constraint(equalTo: alertContentStackView.leadingAnchor, constant: 16),
            alertPrimaryButton.trailingAnchor.constraint(equalTo: alertContentStackView.trailingAnchor, constant: -16),
            alertPrimaryButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setActions() {
        alertCloseButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        alertPrimaryButton.addTarget(self, action: #selector(primaryButtonTapped), for: .touchUpInside)
    }
    
    @objc private func closeButtonTapped() {
        dismissAlert()
    }
    
    @objc private func primaryButtonTapped() {
        dismissAlert()
    }
    
    private func dismissAlert() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.alpha = 0
        }) { [weak self] _ in
            self?.dismiss(animated: false) {
                self?.action?()
            }
        }
    }
    
    func set(
        image: UIImage? = nil,
        title: String? = nil,
        message: String? = nil,
        buttonTitle: String? = nil,
        action: (() -> Void)? = nil
    ) {
        alertImageView.image = image
        alertTitleLabel.text = title
        alertMessageLabel.text = message
        self.action = action
        
        alertImageView.isHidden = image == nil
        alertTitleLabel.isHidden = title == nil
        alertMessageLabel.isHidden = message == nil

        if let buttonTitle {
            alertPrimaryButton.setTitle(buttonTitle, for: .normal)
        }
    }
    
    func set(
        titleLabelTextColor: UIColor
    ) {
        alertTitleLabel.textColor = titleLabelTextColor
    }
}
