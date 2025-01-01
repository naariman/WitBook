//
//  BaseTextField.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

class BaseTextField: UITextField {

    private let rightButtonContainerView = UIView()
    private let rightButton = UIButton()
    var rightButtonAction = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        setActions()
        stylize()
    }

    private func addSubviews() {
        addSubview(rightButtonContainerView)
        rightButtonContainerView.addSubview(rightButton)
    }

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
    
        rightButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            rightButton.widthAnchor.constraint(equalToConstant: 20),
            rightButton.heightAnchor.constraint(equalToConstant: 20),
            
            rightButton.leadingAnchor.constraint(equalTo: rightButtonContainerView.leadingAnchor),
            rightButton.centerYAnchor.constraint(equalTo: rightButtonContainerView.centerYAnchor),
            rightButtonContainerView.trailingAnchor.constraint(equalTo: rightButton.trailingAnchor, constant: 12),
            rightButtonContainerView.heightAnchor.constraint(equalTo: rightButton.heightAnchor)
        ]

        layoutConstraints += [
            heightAnchor.constraint(equalToConstant: 48)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = .white

        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = BaseColor.secondary600?.cgColor

        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        leftViewMode = .always

        rightView = rightButtonContainerView
        rightViewMode = .always

        autocorrectionType = .no
        autocapitalizationType = .none

        rightButton.isHidden = true
        rightButton.imageView?.contentMode = .scaleAspectFit
        
        font = .regular14
        textColor = BaseColor.secondary600
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.regular14,
            .foregroundColor: BaseColor.secondary400!
        ]
        attributedPlaceholder = NSAttributedString(
            string: placeholder ?? "",
            attributes: attributes
        )
    }
    
    private func setActions() {
        rightButton.addTarget(self, action: #selector(didTapRightButton), for: .touchUpInside)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

private extension BaseTextField {
    
    @objc func didTapRightButton() {
        rightButtonAction()
    }
}

extension BaseTextField {

    var placeholderText: String? {
        get {
            placeholder
        }
        set {
            let attributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.regular14,
                .foregroundColor: BaseColor.secondary400!
            ]
            attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: attributes
            )
        }
    }
    
    var rightButtonImage: UIImage? {
        get {
            rightButton.imageView?.image
        }
        set {
            rightButton.setImage(newValue?.withRenderingMode(.alwaysOriginal), for: .normal)
        }
    }
    
    var isRightButtonHidden: Bool {
        get {
            rightButton.isHidden
        }
        set {
            rightButton.isHidden = newValue
        }
    }
}
