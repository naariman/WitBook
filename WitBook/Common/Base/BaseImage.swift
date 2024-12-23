//
//  BaseImage.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 17.12.2024.
//

import UIKit

protocol BaseImageProtocol {

    /// UIImage asset value
    var rawValue: String { get }

    var bundle: Bundle { get }
}

extension BaseImageProtocol {

    /// Return a value as **UIImage**
    var uiImage: UIImage? {
        return UIImage(named: rawValue, in: bundle, compatibleWith: nil)
    }

    /// Return a value as **UIImage** with alwaysTemplate rendering mode
    var templateUIImage: UIImage? {
        return UIImage(named: rawValue, in: bundle, compatibleWith: nil)?.withRenderingMode(.alwaysTemplate)
    }

    func uiImage(tintColor: UIColor) -> UIImage? { uiImage?.withTintColor(tintColor) }

    /// Return a value as **CGImage**
    var cgImage: CGImage? {
        return uiImage?.cgImage
    }
}

class BaseImage: RawRepresentable, Equatable {

    /// String raw type
    typealias RawValue = String

    /// Raw asset value
    let rawValue: RawValue

    let bundle: Bundle

    required init?(rawValue: String) { fatalError("Not implemented") }

    /// Initializer
    ///
    /// - Parameters:
    ///   - rawValue: image asset value
    required init(rawValue: String = #function, from bundle: Bundle = .main) {
        self.rawValue = rawValue
        self.bundle = bundle
    }
}

extension BaseImage: BaseImageProtocol {

    static var ic_back: BaseImage { .init() }
}
