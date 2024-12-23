//
//  AuthenticationItem.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

struct AuthenticationItem {

    enum Identifier {
        case titleLabel
        case emailTextField
        case passwordTextField
        case noAccountButton
    }

    var id: Identifier
    var title: String? = nil
    var placeholder: String? = nil
}
