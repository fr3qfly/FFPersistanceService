//
//  Persistable+Types.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import Foundation

extension Persistable where Self: Codable {
    
    public func toPersistableData() throws -> Data {
        return try JSONEncoder().encode(self)
    }
    
    public static func fromPersistableData(_ data: Data) throws -> Self {
        return try JSONDecoder().decode(Self.self, from: data)
    }
    
}

extension String: Persistable {
    public enum PersistableError: LocalizedError {
        case notData(String)
        case notString(Data)
        
        public var errorDescription: String? {
            switch self {
            case .notData(let string):
                return "Couldn't convert \(string) to `Data`"
            case .notString(let data):
                return "Couldn't convert \(data) to `String`"
            }
        }
        
    }
    
    public func toPersistableData() throws -> Data {
        guard let data = self.data(using: .utf8) else {
            throw PersistableError.notData(self)
        }
        return data
    }
    
    public static func fromPersistableData(_ data: Data) throws -> String {
        guard let value = String(data: data, encoding: .utf8) else {
            throw PersistableError.notString(data)
        }
        return value
    }
}

extension Array: Persistable where Element: Codable {}

extension Dictionary: Persistable where Value: Codable, Key: Codable {}

extension Collection where Self: Persistable {
    public func save(at key: String, on service: PersistanceService) throws {
        guard !self.isEmpty else {
            try service.delete(key)
            return
        }
        try service.save(self, at: key)
    }
}
