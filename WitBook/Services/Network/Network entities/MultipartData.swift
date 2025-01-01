//
//  MultipartData.swift
//  WitBook
//
//  Created by rbkusser on 31.12.2024.
//

import Foundation

struct MultipartData {

    let fields: [String: String]
    let files: [MultipartFile]
}

struct MultipartFile {

    let key: String
    let filename: String
    let data: Data
    let mimeType: String
}

extension Data {

    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
