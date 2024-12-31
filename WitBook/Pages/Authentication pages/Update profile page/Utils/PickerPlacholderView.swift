//
//  PickerPlacholderView.swift
//  WitBook
//
//  Created by rbkusser on 30.12.2024.
//

import UIKit

class PickerPlaceholderView: UIView {
    
    private let topLineView = UIView()
    private let titleLabel = UILabel()
    private let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        setLayoutConstraints()
        stylize()
        setActions()
    }
    
    private func addSubviews() {
        addSubviews(
            topLineView,
            titleLabel,
            imageView
        )
    }
    
    private func setLayoutConstraints() {
        var layoutConstraints = [NSLayoutConstraint]()
        
        layoutConstraints += [
            heightAnchor.constraint(equalToConstant: 190),
            widthAnchor.constraint(equalToConstant: 264)
        ]
        
        topLineView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            topLineView.topAnchor.constraint(equalTo: topAnchor),
            topLineView.rightAnchor.constraint(equalTo: rightAnchor),
            topLineView.leftAnchor.constraint(equalTo: leftAnchor),
            topLineView.heightAnchor.constraint(equalToConstant: 12)
        ]
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            titleLabel.topAnchor.constraint(equalTo: topLineView.bottomAnchor, constant: 16),
            titleLabel.leftAnchor.constraint(equalTo: topLineView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: topLineView.rightAnchor)
        ]
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        layoutConstraints += [
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 94),
            imageView.heightAnchor.constraint(equalToConstant: 94),
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(layoutConstraints)
    }
    
    private func stylize() {
        backgroundColor = .white
        
        titleLabel.textAlignment = .center
        titleLabel.textColor = BaseColor._313643.uiColor
        titleLabel.font = .medium22
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.cornerRadius = 8
        
        topLineView.backgroundColor = BaseColor.primary200
        topLineView.layer.cornerRadius = 8
        topLineView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        imageView.contentMode = .scaleAspectFill
    }

    private func setActions() {}

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}

extension PickerPlaceholderView {
    
    var titleText: String? {
        get {
            titleLabel.text
        }
        set {
            titleLabel.text = newValue
        }
    }
    
    var image: UIImage? {
        get  {
            imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
}
