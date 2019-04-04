import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SecureStorageTests.allTests),
        testCase(UserDefaultsTests.allTests),
        testCase(PersistableTests.allTests)
    ]
}
#endif
