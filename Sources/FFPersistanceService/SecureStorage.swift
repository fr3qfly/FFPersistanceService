//
//  SecureStorage.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation
import Security

let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class SecureStorage: NSObject {
    enum KeychainError: LocalizedError {
        case dataRetrieval(String)
        
        var errorDescription: String? {
            switch self {
            case .dataRetrieval(let status):
                return "Nothing was retrieved from the keychain. Status code \(status)"
            }
        }
    }
    
    let serviceName: NSString
    
    init(serviceName: String) {
        self.serviceName = serviceName as NSString
    }
    
    static let shared: SecureStorage = SecureStorage(serviceName: Bundle.main.bundleIdentifier ?? "com.keychain.noname")
    
    func save(data: Data, key: String) {
        let data = data as NSData
        let key = key as NSString
        
        let keychainQuery = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, serviceName, data], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        SecItemDelete(keychainQuery as CFDictionary)
        
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    func load(key: String) throws -> Data {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(
            objects: [kSecClassGenericPasswordValue, key, serviceName, kCFBooleanTrue as Any, kSecMatchLimitOneValue],
            forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var storedItem: AnyObject?
        let status = SecItemCopyMatching(keychainQuery as CFDictionary, &storedItem)
        
        guard status == errSecSuccess,
            let data = storedItem as? NSData else {
                var message = "\(status)"
                if #available(iOS 11.3, *) {
                    let error = SecCopyErrorMessageString(status, nil)
                    message = String(describing: error)
                }
            throw KeychainError.dataRetrieval(message)
        }
        return data as Data
    }
    
    func delete(key: String) {
        let keychainQuery = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, serviceName], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue])
        
        SecItemDelete(keychainQuery as CFDictionary)
    }
}
