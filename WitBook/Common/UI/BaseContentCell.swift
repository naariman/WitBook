//
//  BaseContentCell.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

class BaseContentCell<T: ResettableView>: UITableViewCell {

    private let containerView = UIView()
    let view = T()

    private var topConstraint: NSLayoutConstraint?
    private var leftConstraint: NSLayoutConstraint?
    private var bottomConstraint: NSLayoutConstraint?
    private var rightConstraint: NSLayoutConstraint?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubviews()
        setLayoutConstraints()
        stylize()
    }

    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(view)
    }

    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()

        containerView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += containerView.getLayoutConstraints(
            over: contentView,
            safe: false,
            left: 16,
            right: 16
        )

        view.translatesAutoresizingMaskIntoConstraints = false
        let inset = view.contentInset
        let topConstraint = view.topAnchor.constraint(
            equalTo: containerView.topAnchor,
            constant: inset.top
        )
        let leftConstraint = view.leftAnchor.constraint(
            equalTo: containerView.leftAnchor,
            constant: inset.left
        )
        let bottomConstraint = view.bottomAnchor.constraint(
            equalTo: containerView.bottomAnchor,
            constant: -inset.bottom
        )
        let rightConstraint = view.rightAnchor.constraint(
            equalTo: containerView.rightAnchor,
            constant: -inset.right
        )

        self.topConstraint = topConstraint
        self.leftConstraint = leftConstraint
        self.bottomConstraint = bottomConstraint
        self.rightConstraint = rightConstraint

        layoutConstraints += [topConstraint, leftConstraint, bottomConstraint, rightConstraint]
        NSLayoutConstraint.activate(layoutConstraints)
    }

    private func stylize() {
        selectionStyle = .none
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BaseContentCell {

    func setMargin(top: CGFloat) {
        topConstraint?.constant = abs(top)
    }

    func setMargin(left: CGFloat) {
        leftConstraint?.constant = abs(left)
    }

    func setMargin(bottom: CGFloat) {
        bottomConstraint?.constant = -abs(bottom)
    }

    func setMargin(right: CGFloat) {
        rightConstraint?.constant = -abs(right)
    }

    func set(containerBackgroundColor: UIColor) {
        containerView.backgroundColor = containerBackgroundColor
    }
}
