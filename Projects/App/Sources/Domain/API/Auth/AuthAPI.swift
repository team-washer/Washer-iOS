//
//  AuthAPI.swift
//  Washer
//
//  Created by 서지완 on 3/12/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Foundation
import Moya

public enum AuthAPI {
    case signUp(param: SignUpRequest)
    case signIn(param: SignInRequest)
    case refresh(idToken: String)
    case signUpMailSend(email: String)
    case signUpMailVerification()
}

extension AuthAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://port-0-washer-backend-m8b4oucx4149eb8a.sel4.cloudtype.app")!
    }

    public var path: String {
        switch self {
        case .signUp:
            return "/auth/signup"
        case .signIn:
            return "/auth/signin"
        case .refresh:
            return "/auth/"
        case .signUpMailSend:
            return "/auth/signup/mailsend"
        }
    }

    public var method: Moya.Method {
        switch self {
        case .signUp, .signIn, .signUpMailSend:
            return .post
        case .refresh:
            return .patch
        }
    }

    public var sampleData: Data {
        return "{}".data(using: .utf8)!
    }

    public var task: Task {
        switch self {
        case .signUp(let param):
            return .requestJSONEncodable(param)
        case .signIn(let param):
            return .requestJSONEncodable(param)
        case .refresh(let idToken):
            return .requestParameters(parameters: ["idToken": idToken], encoding: JSONEncoding.default)
        case .signUpMailSend(let email):
            return .requestParameters(parameters: ["email": email], encoding: JSONEncoding.default)
        }
    }

    public var headers: [String: String]? {
        switch self {
        case .refresh(idToken: let idToken):
            return [
                "Content-Type": "application/json",
                "Refresh-Token": idToken
            ]
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
