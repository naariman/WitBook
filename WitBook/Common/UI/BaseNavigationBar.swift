//
//  BaseNavigationBar.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 22.12.2024.
//

import UIKit

class BaseNavigationBar: UIView {

    private let titleLabel = UILabel()
    private let rightButton = UIButton(type: .system)
    var rightButtonAction = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        stylize()
    }

    private func addSubviews() {
        addSubview(rightButton)
    }

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()

        layoutConstraints += [

        ]

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            rightButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            rightButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
