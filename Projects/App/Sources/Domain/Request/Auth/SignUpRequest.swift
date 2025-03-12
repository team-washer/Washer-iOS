//
//  SignUpRequest.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation

public struct SignUpRequest: Codable {
    var email: String
    var password: String
    var name: String
    var grade: String
    var classRoom: String
    var number: String
    var gender: String
    var room: String

    public init(email: String, password: String, name: String, grade: String, classRoom: String, number: String, gender: String, room: String) {
        self.email = email
        self.password = password
        self.name = name
        self.grade = grade
        self.classRoom = classRoom
        self.number = number
        self.gender = gender
        self.room = room
    }
}
