//
//  PersistableTests.swift
//  PersistanceServiceTests
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import XCTest
@testable import FFPersistanceService

let kKeychainKey = "keychainKey"

class PersistableTests: XCTestCase {
    
    static let allTests = [
        ("testStringOnUserDefaults", testStringOnUserDefaults),
        ("testMockCodableOnUserDefaults", testMockCodableOnUserDefaults),
        ("testMockCodableOnKeychain", testMockCodableOnKeychain),
        ("testStringArrayOnKeychain", testStringArrayOnKeychain),
        ("testIntArrayOnUserDefaults", testIntArrayOnUserDefaults),
        ("testUserDefaultsPersistable", testUserDefaultsPersistable),
        ("testKeychainPersistable", testKeychainPersistable),
        ("testPersistanceKeyRepresentable", testPersistanceKeyRepresentable),
        ("testKeychainPersistableOnUserDefaults", testKeychainPersistableOnUserDefaults)
        
    ]
    
    let key = "key"
    
    var sut: Persistable!
    override func setUp() {
    }

    override func tearDown() {
        try? PersistanceServiceType.userDefaults.persistanceService.delete(key)
        try? PersistanceServiceType.secureStorage.persistanceService.delete(key)
        try? PersistanceServiceType.secureStorage.persistanceService.delete(kKeychainKey)
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
        var result = try? sutType.get(from: key, on: .secureStorage)
        XCTAssertNil(result)
        try sut.save(at: key, on: .secureStorage)
        result = try sutType.get(from: key, on: .secureStorage)
        XCTAssertEqual(result, expected)
        try sut.delete(from: key, on: .secureStorage)
        result = try? sutType.get(from: key, on: .secureStorage)
        XCTAssertNil(result)
    }
    
    func testStringArrayOnKeychain() throws {
        let expected = ["Value1", "Value2"]
        let sutType = [String].self
        sut = expected
        var result = try? sutType.get(from: key, on: .secureStorage)
        XCTAssertNil(result)
        try sut.save(at: key, on: .secureStorage)
        result = try sutType.get(from: key, on: .secureStorage)
        XCTAssertEqual(result, expected)
        try ["",""].save(at: key, on: .secureStorage)
        result = try sutType.get(from: key, on: .secureStorage)
        XCTAssertNotEqual(result, expected)
        try sut.delete(from: key, on: .secureStorage)
        result = try? sutType.get(from: key, on: .secureStorage)
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
    
    func testEmptyArrayDeletesValueOnUserDefaults() throws {
        var initial: [String] = ["1","2"]
        let sutType = [String].self
        try initial.save(at: key, on: .userDefaults)
        var result: [String]? = try sutType.get(from: key, on: .userDefaults)
        XCTAssertEqual(result, initial)
        initial = []
        try initial.save(at: key, on: .userDefaults)
        result = try? sutType.get(from: key, on: .userDefaults)
        XCTAssertNil(result)
    }
    
    func testEmptyValue() {
        do {
            _ = try MockKeychainPersistable.get()
            XCTFail("Should have throw error")
        } catch {
            XCTAssertEqual("\(error)", "dataRetrieval(\"Optional(The specified item could not be found in the keychain.)\")")
        }
    }
}
