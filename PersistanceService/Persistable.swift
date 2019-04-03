//
//  Persistable.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

public protocol Persistable {
    func save(at key: String, on service: PersistanceService) throws
    static func get(from key: String, on service: PersistanceService) throws -> Self
    static func delete(from key: String, on service: PersistanceService) throws
    
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
    public func save(at key: String, on service: PersistanceService) throws {
        try service.save(self, at: key)
    }
    
    public func save(at key: String, on type: PersistanceServiceType) throws {
        try self.save(at: key, on: type.persistanceService)
    }
    
    public static func get(from key: String, on service: PersistanceService) throws -> Self {
        return try service.get(Self.self, from: key)
    }
    
    public static func get(from key: String, on type: PersistanceServiceType) throws -> Self {
        return try Self.get(from: key, on: type.persistanceService)
    }
    
    public func delete(from key: String, on service: PersistanceService) throws {
        try Self.delete(from: key, on: service)
    }
    
    public func delete(from key: String, on type: PersistanceServiceType) throws {
        try delete(from: key, on: type.persistanceService)
    }
    
    public static func delete(from key: String, on service: PersistanceService) throws {
        try service.delete(key)
    }
    
    public static func delete(from key: String, on type: PersistanceServiceType) throws {
        try delete(from: key, on: type.persistanceService)
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
