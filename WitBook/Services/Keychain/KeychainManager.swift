//
//  Keychain Manager.swift
//  WitBook
//
//  Created by rbkusser on 29.12.2024.
//

import Foundation

class KeychainManager {

    enum KeychainError: Error {
        case saveError(OSStatus)
        case readError(OSStatus)
        case notFound
    }
    
    enum KeychainKey: String {
        case accessToken
        case refreshToken
        
        var service: String {
            "com.app.\(self.rawValue)"
        }
    }
    
    func save(_ value: String, for key: KeychainKey) throws {
        guard let data = value.data(using: .utf8) else { return }
        
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key.service as AnyObject,
            kSecAttrAccount as String: key.rawValue as AnyObject,
            kSecValueData as String: data as AnyObject
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            throw KeychainError.saveError(status)
        }
    }
    
    func getValue(for key: KeychainKey) throws -> String {
        let query: [String: AnyObject] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: key.service as AnyObject,
            kSecAttrAccount as String: key.rawValue as AnyObject,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status != errSecItemNotFound else {
            throw KeychainError.notFound
        }
        
        guard status == errSecSuccess,
              let tokenData = result as? Data,
              let value = String(data: tokenData, encoding: .utf8) else {
            throw KeychainError.readError(status)
        }
        
        return value
    }
}
