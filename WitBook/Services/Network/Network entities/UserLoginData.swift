//
//  UserLoginData.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

struct UserLoginData: Encodable {

    var email: String
    var password: String
    
    init() {
        email = ""
        password = ""
    }
}
