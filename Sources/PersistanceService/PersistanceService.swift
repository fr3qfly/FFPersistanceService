//
//  PersistanceService.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

public enum PersistanceServiceType {
    case userDefaults
    case keyChain
    
    var persistanceService: PersistanceService {
        switch self {
        case .userDefaults:
            return UserDefaults.standard
        case .keyChain:
            return Keychain.shared
        }
    }
}

public protocol PersistanceService: AnyObject {
    func save<ObjectType>(_ value: ObjectType, at key: String) throws  where ObjectType: Persistable
    func get<ObjectType>(_ type: ObjectType.Type, from key: String) throws -> ObjectType  where ObjectType: Persistable
    func delete(_ key: String) throws
}
