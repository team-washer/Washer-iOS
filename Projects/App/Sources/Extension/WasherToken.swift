//
//  WasherToken.swift
//  Washer
//
//  Created by 서지완 on 3/13/25.
//  Copyright © 2025 Washer. All rights reserved.
//

import Moya
import Security
import Foundation

struct TokenData: Codable {
    let token: String
    let expirationDate: Date
}

public class KeyChain {
    public static let shared = KeyChain()

    // MARK: - Save Token
    func create(key: String, token: String) {
        if let tokenData = token.data(using: .utf8) {
            let query: NSDictionary = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrAccount: key,
                kSecValueData: tokenData
            ]
            SecItemDelete(query)
            SecItemAdd(query, nil)
        }
    }

    func saveTokenWithExpiration(key: String, token: String, expiresIn: TimeInterval) {
        let expirationDate = Date().addingTimeInterval(expiresIn)
        let tokenData = TokenData(token: token, expirationDate: expirationDate)

        if let encodedData = try? JSONEncoder().encode(tokenData),
           let tokenString = String(data: encodedData, encoding: .utf8) {
            create(key: key, token: tokenString)
        }
    }

    // MARK: - Load Token
    func read(key: String) -> String? {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue as Any,
            kSecMatchLimit: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query, &dataTypeRef)

        if status == errSecSuccess,
           let retrievedData = dataTypeRef as? Data {
            return String(data: retrievedData, encoding: .utf8)
        }
        return nil
    }

    func loadTokenWithExpiration(key: String) -> TokenData? {
        if let tokenString = read(key: key),
           let tokenData = tokenString.data(using: .utf8) {
            return try? JSONDecoder().decode(TokenData.self, from: tokenData)
        }
        return nil
    }

    // MARK: - Token Validation
    func isTokenExpired(key: String) -> Bool {
        if let tokenData = loadTokenWithExpiration(key: key) {
            return tokenData.expirationDate < Date()
        }
        return true
    }

    // MARK: - Update Token
    func updateItem(token: String, key: String) -> Bool {
        let prevQuery: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        let updateQuery: [CFString: Any] = [
            kSecValueData: token.data(using: .utf8) as Any
        ]

        let status = SecItemUpdate(prevQuery as CFDictionary, updateQuery as CFDictionary)
        return status == errSecSuccess
    }

    // MARK: - Delete Token
    func delete(key: String) {
        let query: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        SecItemDelete(query)
    }
}

public struct Const {
    public struct KeyChainKey {
        public static let accessToken = "accessToken"
        public static let refreshToken = "refreshToken"
    }
}
