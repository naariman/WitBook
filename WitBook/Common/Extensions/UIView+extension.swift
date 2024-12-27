//
//  UIView+extension.swift
//  WitBook
//
//  Created by rbkusser on 27.12.2024.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach {
            addSubview($0)
        }
    }
}
