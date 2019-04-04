//
//  PersistableTests.swift
//  PersistanceServiceTests
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import XCTest
@testable import PersistanceService

let kKeychainKey = "keychainKey"

class PersistableTests: XCTestCase {
    
    let key = "key"
    
    var sut: Persistable!
    override func setUp() {
    }

    override func tearDown() {
        try? PersistanceServiceType.userDefaults.persistanceService.delete(key)
        try? PersistanceServiceType.keyChain.persistanceService.delete(key)
        try? PersistanceServiceType.keyChain.persistanceService.delete(kKeychainKey)
        sut = nil
    }
    
    func testStringOnUserDefaults() throws {
        let expected = "Value"
        let sutType = String.self
        sut = expected
        var result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
        try sut.save(at: key, on: .userDefaults)
        result = try sutType.get(from: key, on: .userDefaults)
        XCTAssertEqual(result, expected)
        try sut.delete(from: key, on: .userDefaults)
        result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
    }
    
    func testMockCodableOnUserDefaults() throws {
        let expected = MockPersistable()
        let sutType = MockPersistable.self
        sut = expected
        var result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
        try sut.save(at: key, on: .userDefaults)
        result = try sutType.get(from: key, on: .userDefaults)
        XCTAssertEqual(result, expected)
        try sut.delete(from: key, on: .userDefaults)
        result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
    }
    
    func testMockCodableOnKeychain() throws {
        let expected = MockPersistable()
        let sutType = MockPersistable.self
        sut = expected
        var result = try? sutType.get(from: key, on: .keyChain)
        XCTAssertNil(result)
        try sut.save(at: key, on: .keyChain)
        result = try sutType.get(from: key, on: .keyChain)
        XCTAssertEqual(result, expected)
        try sut.delete(from: key, on: .keyChain)
        result = try? sutType.get(from: key, on: .keyChain)
        XCTAssertNil(result)
    }
    
    func testStringArrayOnKeychain() throws {
        let expected = ["Value1", "Value2"]
        let sutType = [String].self
        sut = expected
        var result = try? sutType.get(from: key, on: .keyChain)
        XCTAssertNil(result)
        try sut.save(at: key, on: .keyChain)
        result = try sutType.get(from: key, on: .keyChain)
        XCTAssertEqual(result, expected)
        try ["",""].save(at: key, on: .keyChain)
        result = try sutType.get(from: key, on: .keyChain)
        XCTAssertNotEqual(result, expected)
        try sut.delete(from: key, on: .keyChain)
        result = try? sutType.get(from: key, on: .keyChain)
        XCTAssertNil(result)
    }
    
    func testIntArrayOnUserDefaults() throws {
        let expected = [1, 2, 3]
        let sutType = [Int].self
        sut = expected
        var result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
        try sut.save(at: key, on: .userDefaults)
        result = try sutType.get(from: key, on: .userDefaults)
        XCTAssertEqual(result, expected)
        try sut.delete(from: key, on: .userDefaults)
        result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
    }
    
    func testUserDefaultsPersistable() throws {
        let expected = MockUserDefaultsPersistable()
        let sutType = MockUserDefaultsPersistable.self
        var result = try? sutType.get(from: key)
        XCTAssertNil(result)
        try expected.save(at: key)
        result = try sutType.get(from: key)
        XCTAssertEqual(result, expected)
        try expected.delete(from: key)
        result = try? sutType.get(from: key)
        XCTAssertNil(result)
    }
    
    func testKeychainPersistable() throws {
        let expected = MockKeychainPersistable()
        let sutType = MockKeychainPersistable.self
        var result = try? sutType.get(from: key)
        XCTAssertNil(result)
        try expected.save(at: key)
        result = try sutType.get(from: key)
        XCTAssertEqual(result, expected)
        try expected.delete(from: key)
        result = try? sutType.get(from: key)
        XCTAssertNil(result)
    }
    
    func testPersistanceKeyRepresentable() throws {
        let expected = MockKeychainPersistable()
        let sutType = MockKeychainPersistable.self
        var result = try? sutType.get()
        XCTAssertNil(result)
        try expected.save()
        result = try sutType.get()
        XCTAssertEqual(result, expected)
        try expected.delete()
        result = try? sutType.get()
        XCTAssertNil(result)
    }
    
    func testKeychainPersistableOnUserDefaults() throws {
        let expected = MockKeychainPersistable()
        let sutType = MockKeychainPersistable.self
        sut = expected
        var result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
        try sut.save(at: key, on: .userDefaults)
        result = try sutType.get(from: key, on: .userDefaults)
        XCTAssertEqual(result, expected)
        try sut.delete(from: key, on: .userDefaults)
        result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
    }

}

struct MockPersistable: Codable, Equatable, Persistable {
    let property = "Property"
}

struct MockUserDefaultsPersistable: Codable, Equatable, UserDefaultsPersistable {
    let property = "Property"
}

struct MockKeychainPersistable: Codable, Equatable, KeychainPersistable {
    let property = "Property"
}

extension MockKeychainPersistable: PersistanceKeyRepresentable {
    static var persistanceKey: String {
        return kKeychainKey
    }
}
