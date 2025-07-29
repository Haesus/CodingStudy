//
//  KeyChainManager.swift
//  KeyChainTest
//
//  Created by 윤해수 on 7/29/25.
//

import Foundation
import Security

final class KeyChainManager {
    static let shared = KeyChainManager()
    private init() {}

    func save(key: String, value: String, kSecClassString: CFString = kSecClassGenericPassword) -> Bool {
        if let data = value.data(using: .utf8) {
            let query: [String: Any] = [
                kSecClass as String: kSecClassString,
                kSecAttrAccount as String: key,
                kSecValueData as String: data
            ]
            SecItemDelete(query as CFDictionary) // 기존 값 제거
            let status = SecItemAdd(query as CFDictionary, nil)
            return status == errSecSuccess
        }
        return false
    }

    func load(key: String, kSecClassString: CFString = kSecClassGenericPassword) -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassString,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]

        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)

        if status == errSecSuccess,
           let retrievedData = dataTypeRef as? Data,
           let value = String(data: retrievedData, encoding: .utf8) {
            return value
        }
        return nil
    }

    func delete(key: String, kSecClassString: CFString = kSecClassGenericPassword) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassString,
            kSecAttrAccount as String: key
        ]
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
