//
//  NetworkLogger.swift
//  WitBook
//
//  Created by rbkusser on 29.12.2024.
//

import Foundation

struct NetworkLogger {
    
    static func logRequest(_ request: URLRequest) {
        let requestLog = """
        📤 REQUEST
        -> URL: \(request.url?.absoluteString ?? "nil")
        -> METHOD: \(request.httpMethod ?? "nil")
        -> HEADERS: \(request.allHTTPHeaderFields?.prettyPrinted ?? "nil")
        -> BODY: \(request.httpBody?.jsonPrettyPrinted ?? "nil")
        """
        print(requestLog)
    }

    static func logResponse(_ response: URLResponse?, data: Data?, error: Error?) {
        var statusCode = 0
        if let httpResponse = response as? HTTPURLResponse {
            statusCode = httpResponse.statusCode
        }
        
        let jsonString = data?.jsonPrettyPrinted ?? "No data"
        
        let statusEmoji = (200...299).contains(statusCode) ? "✅" : "❌"
        let responseLog = """
        \(statusEmoji) RESPONSE
        -> URL: \(response?.url?.absoluteString ?? "nil")
        -> STATUS: \(statusCode)
        -> ERROR: \(error?.localizedDescription ?? "nil")
        -> DATA: \(jsonString)
        """
        print(responseLog)
    }
}
