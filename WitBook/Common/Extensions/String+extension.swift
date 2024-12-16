//
//  String+extension.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 16.12.2024.
//

import Foundation

extension String {

    func localized() -> String {
        let path = Bundle.main.path(forResource: "en", ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: "Localizable", bundle: bundle!, value: self, comment: self)
    }
}
