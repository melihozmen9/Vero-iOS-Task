//
//  Login.swift
//  iOS-Task
//
//  Created by Kullanici on 1.03.2023.
//

import Foundation
struct OAuthResponse: Decodable {
    let oauth: OAuth
}

struct OAuth: Decodable {
    let accessToken: String
//    let expiresIn: Int
//    let tokenType: String
//    let scope: String?
//    let refreshToken: String
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
//        case expiresIn = "expires_in"
//        case tokenType = "token_type"
//        case scope
//        case refreshToken = "refresh_token"
    }
}
