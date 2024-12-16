//
//  URLResponse.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import Foundation

extension URLResponse {

    func log(data: Data?, error: Error?) {
        var statusCode = 0
        if let httpUrlResponse = self as? HTTPURLResponse {
            statusCode = httpUrlResponse.statusCode
        }

        let networkResponse = """
        ⚡️⚡️⚡️⚡️ RESPONSE START ⚡️⚡️⚡️⚡️
        -> URL: \(url?.absoluteString ?? "nil")
        -> STATUS CODE: \(statusCode)
        -> ERROR: \(String(describing: error))
        -> DATA JSON: \(String(describing: data?.jsonObject))"
        ⚡️⚡️⚡️⚡️ RESPONSE END ⚡️⚡️⚡️⚡️
        """
        print(networkResponse)
    }
}
