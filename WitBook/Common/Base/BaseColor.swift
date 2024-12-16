//
//  BaseColor.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 08.12.2024.
//

import UIKit.UIColor

enum BaseColor: String, CaseIterable {

    case _31AFC6

    var uiColor: UIColor { UIColor(hex: hex) ?? .black }
    var cgColor: CGColor { uiColor.cgColor }
    var hex: String { rawValue.replacingOccurrences(of: "_", with: "#") }
}

extension BaseColor {

    static var primary200: UIColor? { UIColor(hex: "#BCD9FF") }
    static var primary300: UIColor? { UIColor(hex: "#729FD5") }
    static var primary400: UIColor? { UIColor(hex: "#336DB4") }
    static var primary500: UIColor? { UIColor(hex: "#1757A4") }

    static var secondary200: UIColor? { UIColor(hex: "#EBF0F6") }
    static var secondary300: UIColor? { UIColor(hex: "#B3BAC7") }
    static var secondary400: UIColor? { UIColor(hex: "#7F87A0") }
    static var secondary500: UIColor? { UIColor(hex: "#4D566E") }
    static var secondary600: UIColor? { UIColor(hex: "#4D566E") }
}
