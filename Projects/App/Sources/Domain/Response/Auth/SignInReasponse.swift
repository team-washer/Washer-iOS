//
//  SignInReasponse.swift
//  Washer
//
//  Created by 서지완 on 3/13/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation

public struct SignInResponse: Codable {
    var access: String
    var refresh: String

    public init(access: String, refresh: String) {
        self.access = access
        self.refresh = refresh
    }
}
