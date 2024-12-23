//
//  UIView+extension.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 16.12.2024.
//

import UIKit

extension UIView: BaseLayoutConstraintProtocol {

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview)
    }

    static var reuseId: String {
        String(describing: self)
    }
}
