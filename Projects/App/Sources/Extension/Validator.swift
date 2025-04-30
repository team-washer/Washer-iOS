//
//  Validator.swift
//  Washer
//
//  Created by 서지완 on 4/8/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation

struct Validator {
    static let emailRegex = "^s\\d{5}$"
    static let passwordRegex = "^(?=.*[^A-Za-z0-9]).{8,16}$"

    static func isValidEmail(_ email: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", emailRegex)
            .evaluate(with: email)
    }

    static func isValidPassword(_ password: String) -> Bool {
        NSPredicate(format: "SELF MATCHES %@", passwordRegex)
            .evaluate(with: password)
    }
}

extension Character {
    var isHangul: Bool {
        return ("가"..."힣").contains(self)
    }
}
