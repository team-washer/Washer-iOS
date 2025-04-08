//
//  SignInReasponse.swift
//  Washer
//
//  Created by 서지완 on 3/13/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation

public struct SignInResponse: Codable {
    var accessToken: String
    var accessTokenExpiresIn: String
    var refreshToken: String
    var refreshTokenExpiresIn: String
    var role: String

    public init(
        accessToken: String,
        accessTokenExpiresIn: String,
        refreshToken: String,
        refreshTokenExpiresIn: String,
        role: String
    ) {
        self.accessToken = accessToken
        self.accessTokenExpiresIn = accessTokenExpiresIn
        self.refreshToken = refreshToken
        self.refreshTokenExpiresIn = refreshTokenExpiresIn
        self.role = role
    }
}
