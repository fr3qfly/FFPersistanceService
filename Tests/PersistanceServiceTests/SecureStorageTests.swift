//
//  KeychainTests.swift
//  PersistanceServiceTests
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import XCTest
@testable import PersistanceService

class SecureStorageTests: XCTestCase {
    
    static let allTests = [
        ("testSave", testSave),
        ("testSaveOnPersistableType", testSaveOnPersistableType),
        ("testDelete", testDelete),
        ("testDeleteOnPersistableType", testDeleteOnPersistableType),
        ("testOverwrite", testOverwrite)
    ]
    
    let key = "TestKey"
    var sut: SecureStorage!

    override func setUp() {
        super.setUp()
        sut = SecureStorage.shared
    }

    override func tearDown() {
        super.tearDown()
        sut.delete(key: key)
        sut = nil
    }
    
    func testSave() throws {
        var result: Data? = try? sut.load(key: key)
        XCTAssertNil(result)
        let data = "Secret".data(using: .utf8)!
        sut.save(data: data, key: key)
        result = try sut.load(key: key)
        XCTAssertEqual(result, data)
    }
    
    func testSaveOnPersistableType() throws {
        var result = try? sut.get(String.self, from: key)
        XCTAssertNil(result)
        let data = "Secret"
        try sut.save(data, at: key)
        result = try sut.get(String.self, from: key)
        XCTAssertEqual(result, data)
    }
    
    func testDelete() {
        let data = "Secret".data(using: .utf8)!
        sut.save(data: data, key: key)
        var result: Data? = try? sut.load(key: key)
        XCTAssertNotNil(result)
        sut.delete(key: key)
        result = try? sut.load(key: key)
        XCTAssertNil(result)
    }
    
    func testDeleteOnPersistableType() throws {
        let data = "Secret"
        try sut.save(data, at: key)
        var result = try? sut.get(String.self, from: key)
        XCTAssertNotNil(result)
        try sut.delete(key)
        result = try? sut.get(String.self, from: key)
        XCTAssertNil(result)
    }
    
    func testOverwrite() throws {
        let data = "Secret".data(using: .utf8)!
        sut.save(data: data, key: key)
        let newData = "NewSecret".data(using: .utf8)!
        sut.save(data: newData, key: key)
        let result = try sut.load(key: key)
        XCTAssertEqual(result, newData)
    }
}
