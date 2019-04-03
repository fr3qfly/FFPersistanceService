//
//  UserDefaults+PersistanceService.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

extension UserDefaults: PersistanceService {
    enum UserDefaultsError: Error {
        case notData
        
        var localizedDescription: String {
            switch self {
            case .notData:
                return "Stored object wasn't valid Data"
            }
        }
    }
    public func save<ObjectType>(_ value: ObjectType, at key: String) throws where ObjectType : Persistable {
        let data = try value.toPersistableData()
        self.set(data, forKey: key)
    }
    
    public func get<ObjectType>(_ type: ObjectType.Type, from key: String) throws -> ObjectType where ObjectType : Persistable {
        guard let data = value(forKey: key) as? Data else {
            throw UserDefaultsError.notData
        }
        return try ObjectType.fromPersistableData(data)
    }
    
    public func delete(_ key: String) throws {
        self.removeObject(forKey: key)
    }
    
    
}
