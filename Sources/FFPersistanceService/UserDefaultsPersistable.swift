//
//  UserDefaultsPersistable.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

public protocol UserDefaultsPersistable: PredefinedPersistable {}

extension UserDefaultsPersistable {
    public func save(at key: String) throws {
        try save(at: key, on: .userDefaults)
    }
    
    public static func get(from key: String, defaultValue: Self? = nil) throws -> Self {
        return try get(from: key, on: .userDefaults, defaultValue: defaultValue)
    }
    
    public static func delete(from key: String) throws {
        try delete(from: key, on: .userDefaults)
    }
}
