//
//  SignUpMailVerificationRequest.swift
//  Washer
//
//  Created by 서지완 on 5/21/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation

public struct SignUpMailVerificationRequest: Codable {
    var email: String
    var code: String

    public init(email: String, code: String) {
        self.email = email
        self.code = code
    }
}
