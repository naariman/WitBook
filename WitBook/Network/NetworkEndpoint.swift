//
//  NetworkEndpoint.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 15.12.2024.
//

import Foundation

protocol NetworkEndpoint {

    var serverUrl: String { get }
    var apiUrl: String { get }
    var method: HTTPMethod { get }
    var body: Encodable? { get }
    var header: [String: String]? { get }
}

extension NetworkEndpoint {

    var url: String { serverUrl + apiUrl }
}
