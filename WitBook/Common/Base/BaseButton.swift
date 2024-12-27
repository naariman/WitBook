//
//  BaseButton.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 16.12.2024.
//

import UIKit

class BaseButton: UIButton {

    private let activityIndicatorView = UIActivityIndicatorView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        setLayoutConstraints()
        stylize()
    }

    private func addSubviews() {
        addSubview(activityIndicatorView)
    }

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()

        layoutConstraints += [
            heightAnchor.constraint(equalToConstant: 48)
        ]

        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]

        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        backgroundColor = BaseColor.primary400

        titleLabel?.font = .medium16
        setTitleColor(.white, for: .normal)
        setTitleColor(.gray, for: .disabled)
        setTitleColor(.white.withAlphaComponent(0.5), for: .highlighted)

        layer.cornerRadius = 8

        activityIndicatorView.hidesWhenStopped = true
        activityIndicatorView.color = .white
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension BaseButton {

    func startLoading() {
        activityIndicatorView.startAnimating()
        setTitle("", for: .normal)
        isEnabled = false
    }

    func stopLoading() {
        activityIndicatorView.stopAnimating()
        setTitle(title, for: .normal)
        isEnabled = true
    }
}

extension BaseButton {

    var title: String? {
        get {
            title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }
}
