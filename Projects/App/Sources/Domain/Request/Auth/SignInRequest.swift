//
//  SignInRequest.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation

public struct SignInRequest: Codable {
    var email: String
    var password: String

    public init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
