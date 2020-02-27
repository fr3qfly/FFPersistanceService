//
//  KeyChain+PersistanceService.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

extension SecureStorage: PersistanceService {
    func save<ObjectType>(_ value: ObjectType, at key: String) throws where ObjectType: Persistable {
        let data = try value.toPersistableData()
        save(data: data, key: key)
    }
    
    func get<ObjectType>(_ type: ObjectType.Type, from key: String, defaultValue: ObjectType?) throws -> ObjectType  where ObjectType: Persistable {
        let data: Data
        do {
            data = try load(key: key)
        } catch {
            guard let defaultValue = defaultValue,
                let kcError = error as? SecureStorage.KeychainError,
                case .dataRetrieval(_) = kcError else {
                    throw error
            }
            return defaultValue
        }
        return try ObjectType.fromPersistableData(data)
    }
    
    func delete(_ key: String) throws {
        delete(key: key)
    }
}
