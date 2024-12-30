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


extension UIView {

    func addTapGesture(action: @escaping () -> Void) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        self.addGestureRecognizer(tapGesture)
        objc_setAssociatedObject(self, &UIView.tapActionKey, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    @objc private func handleTapGesture() {
        if let action = objc_getAssociatedObject(self, &UIView.tapActionKey) as? () -> Void {
            action()
        }
    }
    
    private static var tapActionKey: UInt8 = 0
}

