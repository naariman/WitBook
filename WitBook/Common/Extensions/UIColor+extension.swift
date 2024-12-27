//
//  UIColor+extension.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 08.12.2024.
//

import UIKit

extension UIColor {

    convenience init?(hex: String) {
        guard hex.hasPrefix("#") else { return nil }

        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])
        guard hexColor.count == 6 else { return nil }

        let scanner = Scanner(string: hexColor)
        var hexNumber: UInt64 = 0
        guard scanner.scanHexInt64(&hexNumber) else { return nil }

        let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        let b = CGFloat((hexNumber & 0x0000ff)) / 255

        self.init(red: r, green: g, blue: b, alpha: 1)
    }
}
