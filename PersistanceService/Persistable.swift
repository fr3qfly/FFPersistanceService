//
//  Persistable.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

public protocol Persistable {
    func save(at key: String, on type: PersistanceServiceType) throws
    static func get(from key: String, on type: PersistanceServiceType) throws -> Self
    static func delete(from key: String, on type: PersistanceServiceType) throws
    
    func toPersistableData() throws -> Data
    static func fromPersistableData(_ data: Data) throws -> Self
}

public protocol PredefinedPersistable: Persistable {
    func save(at key: String) throws
    static func get(from key: String) throws -> Self
    static func delete(from key: String) throws
}

extension PredefinedPersistable {
    public func delete(from key: String) throws {
        try Self.delete(from: key)
    }
}

extension Persistable {
    public func save(at key: String, on type: PersistanceServiceType) throws {
        try type.persistanceService.save(self, at: key)
    }
    
    public static func get(from key: String, on type: PersistanceServiceType) throws -> Self {
        return try type.persistanceService.get(Self.self, from: key)
    }
    
    public func delete(from key: String, on type: PersistanceServiceType) throws {
        try Self.delete(from: key, on: type)
    }
    
    public static func delete(from key: String, on type: PersistanceServiceType) throws {
        try type.persistanceService.delete(key)
    }
}

extension Optional where Wrapped: Persistable {
    enum PersistableError: Error {
        case nilSave
        
        var localizedDescription: String {
            switch self {
            case .nilSave:
                return "`nil` can't be saved. If you want to remove the value use `delete(from)`"
            }
        }
    }
    
    func save(at key: String, on type: PersistanceServiceType) throws {
        guard let wrapped = self else {
            throw PersistableError.nilSave
        }
        try wrapped.save(at: key, on: type)
    }
    
    static func get(from key: String, on type: PersistanceServiceType) throws -> Wrapped? {
        return try type.persistanceService.get(Wrapped.self, from: key)
    }
    
    static func delete(from key: String, on type: PersistanceServiceType) throws {
        try type.persistanceService.delete(key)
    }
}
