//
//  Mocks.swift
//  PersistanceService
//
//  Created by Balazs Szamody on 4/4/19.
//

import Foundation
import PersistanceService


struct MockPersistable: Codable, Equatable, Persistable {
    let property = "Property"
}

struct MockUserDefaultsPersistable: Codable, Equatable, UserDefaultsPersistable {
    let property = "Property"
}

struct MockKeychainPersistable: Codable, Equatable, SecurePersistable {
    let property = "Property"
}

extension MockKeychainPersistable: PersistanceKeyRepresentable {
    static var persistanceKey: String {
        return kKeychainKey
    }
}
