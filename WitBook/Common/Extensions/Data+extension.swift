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
    
    var jsonPrettyPrinted: String {
           guard let jsonObject = try? JSONSerialization.jsonObject(with: self, options: []),
                 let prettyData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                 let prettyString = String(data: prettyData, encoding: .utf8) else {
               return String(data: self, encoding: .utf8) ?? "Unable to decode data"
           }
           return prettyString
       }
}
