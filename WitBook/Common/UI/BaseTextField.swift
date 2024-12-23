//
//  BaseTextField.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

class BaseTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        stylize()
    }

    private func addSubviews() {}

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()

        layoutConstraints += [
            heightAnchor.constraint(equalToConstant: 48)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = BaseColor.primary400

        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = BaseColor.secondary600?.cgColor
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension BaseTextField {

    var placeholderText: String? {
        get {
            placeholder
        }
        set {
            placeholder = newValue
        }
    }
}
