//
//  UserTokensData.swift
//  WitBook
//
//  Created by Nariman Nogaibayev on 21.12.2024.
//

import Foundation

struct UserTokensData: Decodable {

    let access_token: String
    let refresh_token: String
}
