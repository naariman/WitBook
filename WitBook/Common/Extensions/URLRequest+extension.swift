//
//  URLRequest+extension.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import Foundation

extension URLRequest {

    func log() {
        let requestUrl = self.url?.absoluteString ?? "nil"
        let body = httpBody.map { String(decoding: $0, as: UTF8.self) }

        let networkRequest = """
        ⚡️⚡️⚡️⚡️ REQUEST START ⚡️⚡️⚡️⚡️
        -> URL: \(requestUrl)
        -> METHOD: \(String(describing: httpMethod))
        -> HEADERS: \(String(describing: allHTTPHeaderFields))
        -> BODY: \(String(describing: body))
        ⚡️⚡️⚡️⚡️ REQUEST END ⚡️⚡️⚡️⚡️
        """
        print(networkRequest)
    }
}
