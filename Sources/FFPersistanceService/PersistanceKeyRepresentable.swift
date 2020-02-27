//
//  PersistanceKeyRepresentable.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

public protocol PersistanceKeyRepresentable {
    static var persistanceKey: String { get }
}

extension PredefinedPersistable where Self: PersistanceKeyRepresentable {
    public func save() throws {
        try save(at: Self.persistanceKey)
    }

    public static func get(defaultValue: Self? = nil) throws -> Self {
        return try get(from: persistanceKey, defaultValue: defaultValue)
    }
    
    public static func delete() throws {
        try delete(from: persistanceKey)
    }
    
    public func delete() throws {
        try Self.delete()
    }
}

extension Persistable where Self: PersistanceKeyRepresentable {
    public func save(on type: PersistanceServiceType) throws {
        try save(at: Self.persistanceKey, on: type)
    }
    
    public static func get(on type: PersistanceServiceType, defaultValue: Self? = nil) throws -> Self{
        return try get(from: persistanceKey, on: type, defaultValue: defaultValue)
    }
    
    public static func delete(on type: PersistanceServiceType) throws {
        try delete(from: persistanceKey, on: type)
    }
    
    public func delete(on type: PersistanceServiceType) throws {
        try Self.delete(on: type)
    }
}
