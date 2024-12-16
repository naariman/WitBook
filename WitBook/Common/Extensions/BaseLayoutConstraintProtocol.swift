//
//  BaseLayoutConstraintProtocol.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 16.12.2024.
//

import UIKit

protocol BaseLayoutConstraintProtocol where Self: UIView { }

extension BaseLayoutConstraintProtocol {

    func getLayoutConstraints(over view: UIView, safe: Bool = true, margin: CGFloat) -> [NSLayoutConstraint] {
        return getLayoutConstraints(over: view, safe: safe, left: margin, top: margin, right: margin, bottom: margin)
    }

    func getLayoutConstraints(
        over view: UIView,
        safe: Bool = true,
        left: CGFloat = 0,
        top: CGFloat = 0,
        right: CGFloat = 0,
        bottom: CGFloat = 0
    ) -> [NSLayoutConstraint] {

        let viewTopAnchor = safe ? view.safeAreaLayoutGuide.topAnchor : view.topAnchor
        let viewBottomAnchor = safe ? view.safeAreaLayoutGuide.bottomAnchor : view.bottomAnchor

        return [
            leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: left),
            topAnchor.constraint(equalTo: viewTopAnchor, constant: top),
            trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -abs(right)),
            bottomAnchor.constraint(equalTo: viewBottomAnchor, constant: -abs(bottom))
        ]
    }

    func getLayoutConstraintsByCentering(over view: UIView) -> [NSLayoutConstraint] {
        return [
            centerXAnchor.constraint(equalTo: view.centerXAnchor),
            centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
    }
}
