//
//  BaseBackgroundGradientView.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 16.12.2024.
//

import UIKit

class BaseBackgroundGradientView: UIView {

    private let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradientLayer()
        startAnimating()
    }

    private func setupGradientLayer() {
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            "#32FC67", "#C3F43E", "#FCA83C", "#FCD530", "#FF3B52"
        ].compactMap { UIColor(hex: $0)?.withAlphaComponent(0.1).cgColor }
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.type = .axial
        layer.addSublayer(gradientLayer)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }

    private func startAnimating() {
        let animation = CABasicAnimation(keyPath: "colors")
        animation.fromValue = gradientLayer.colors
        animation.toValue = [
            "#32FC67", "#C3F43E", "#FCA83C", "#FCD530"
        ].compactMap { UIColor(hex: $0)?.withAlphaComponent(0.1).cgColor }
        animation.duration = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        animation.autoreverses = true
        gradientLayer.add(animation, forKey: "colorChange")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


