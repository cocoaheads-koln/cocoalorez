import Foundation

public protocol XCTestCase {
    init()
    func setUp()
    func tearDown()
    static var allTests: [(String, (Self) -> () throws -> Void)] { get }
}

public extension XCTestCase {
    static func run() throws {
        let instance = self.init()

        for (name, closure) in allTests {
            print("Testing \(name) …")
            instance.setUp()

            let test = closure(instance)
            try test()

            instance.tearDown()
        }
    }

    func setUp() {}
    func tearDown() {}
}

// MARK: - Assertions

public func XCTFail(
    _ reason: String? = nil,
    testName: StaticString = #function,
    lineNumber: UInt = #line
) {
    let reason = reason.map { ", \($0)," } ?? ""
    assertionFailure("\(testName) failed\(reason) on line \(lineNumber)")
}

public func XCTAssertEqual<T: Equatable>(
    _ lhs: T?,
    _ rhs: T?,
    testName: StaticString = #function,
    lineNumber: UInt = #line
) {
    guard lhs != rhs else {
        return
    }

    func describe(_ value: T?) -> String {
        return value.map { "\($0)" } ?? "nil"
    }

    // Here we pass on the test name and line number that were
    // collected at this function's call site, rather than
    // recording them from this call.
    XCTFail("\(describe(lhs)) is not equal to \(describe(rhs))",
        testName: testName,
        lineNumber: lineNumber
    )
}
