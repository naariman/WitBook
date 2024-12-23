//
//  ResettableView.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

protocol ResettableView: UIView {

    var contentInset: UIEdgeInsets { get }
    var containerBackgroundColor: UIColor { get }
    var viewToShake: UIView? { get }

    func reset()
}

extension ResettableView {

    var contentInset: UIEdgeInsets { UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16) }
    var containerBackgroundColor: UIColor { .clear }
    var viewToShake: UIView? { nil }

    func shake() {
        guard let viewToShake else { return }

        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-10.0, 10.0, -8.0, 8.0, -6.0, 6.0, -4.0, 4.0, -2.0, 2.0, 0.0]
        viewToShake.layer.add(animation, forKey: "shake")

        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }

    func reset() {}
}
