//
//  Dictionary+extension.swift
//  WitBook
//
//  Created by rbkusser on 29.12.2024.
//

import Foundation

extension Dictionary {

    var prettyPrinted: String {
        guard let data = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
              let string = String(data: data, encoding: .utf8) else {
            return "Unable to format dictionary"
        }
        return string
    }
}
