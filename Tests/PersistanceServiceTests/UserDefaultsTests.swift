//
//  UserDefaultsTests.swift
//  PersistanceServiceTests
//
//  Created by Balazs Szamody on 3/4/19.
//  Copyright © 2019 Fr3qFly. All rights reserved.
//

import XCTest
@testable import PersistanceService

class UserDefaultsTests: XCTestCase {
    static let allTests = [
        ("testSave", testSave),
        ("testDelete", testDelete),
        ("testOverwrite", testOverwrite)
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
        var result: String? = try? sut.get(String.self, from: key)
        XCTAssertNil(result)
        let data = "Value"
        try sut.save(data, at: key)
        result = try sut.get(String.self, from: key)
        XCTAssertEqual(result, "Value")
    }
    
    func testDelete() throws {
        let data = "Value"
        try sut.save(data, at: key)
        var result = try? sut.get(String.self, from: key)
        XCTAssertNotNil(result)
        try sut.delete(key)
        result = try? sut.get(String.self, from: key)
        XCTAssertNil(result)
    }
    
    func testOverwrite() throws {
        try sut.save("Data", at: key)
        let data = "Value"
        try sut.save(data, at: key)
        let result = try sut.get(String.self, from: key)
        XCTAssertEqual(result, data)
    }

}
