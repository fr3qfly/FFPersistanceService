//
//  UserDefaultsTests.swift
//  PersistanceServiceTests
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import XCTest
@testable import FFPersistanceService

class UserDefaultsTests: XCTestCase {
    static let allTests = [
        ("testSave", testSave),
        ("testDelete", testDelete),
        ("testOverwrite", testOverwrite),
        ("testGetDefault", testGetDefault)
    ]
    
    let key = "key"
    
    var sut: PersistanceService!

    override func setUp() {
        sut = UserDefaults.standard
    }

    override func tearDown() {
        try? sut.delete(key)
        sut = nil
    }

    func testSave() throws {
        var result: String? = try? sut.get(String.self, from: key, defaultValue: nil)
        XCTAssertNil(result)
        let data = "Value"
        try sut.save(data, at: key)
        result = try sut.get(String.self, from: key, defaultValue: nil)
        XCTAssertEqual(result, "Value")
    }
    
    func testDelete() throws {
        let data = "Value"
        try sut.save(data, at: key)
        var result = try? sut.get(String.self, from: key, defaultValue: nil)
        XCTAssertNotNil(result)
        try sut.delete(key)
        result = try? sut.get(String.self, from: key, defaultValue: nil)
        XCTAssertNil(result)
    }
    
    func testOverwrite() throws {
        try sut.save("Data", at: key)
        let data = "Value"
        try sut.save(data, at: key)
        let result = try sut.get(String.self, from: key, defaultValue: nil)
        XCTAssertEqual(result, data)
    }
    
    func testGetDefault() {
        do {
            let expected = ""
            let result = try sut.get(String.self, from: "nonExistentKey", defaultValue: expected)
            XCTAssertEqual(result, expected)
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

}
