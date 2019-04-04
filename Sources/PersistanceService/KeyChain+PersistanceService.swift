//
//  KeyChain+PersistanceService.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

extension Keychain: PersistanceService {
    func save<ObjectType>(_ value: ObjectType, at key: String) throws where ObjectType: Persistable {
        let data = try value.toPersistableData()
        save(data: data, key: key)
    }
    
    func get<ObjectType>(_ type: ObjectType.Type, from key: String) throws -> ObjectType  where ObjectType: Persistable {
        let data = try load(key: key)
        return try ObjectType.fromPersistableData(data)
    }
    
    func delete(_ key: String) throws {
        delete(key: key)
    }
}
