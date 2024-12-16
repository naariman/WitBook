//
//  Data+extension.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import Foundation

extension Data {
    
    var jsonObject: Any? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: .allowFragments)
        } catch {
            return nil
        }
    }
}
