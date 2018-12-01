import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(StreamDeckSetColorTests.allTests),
        testCase(StreamDeckProductTests.allTests),
        testCase(StreamDeckKeyPressedTests.allTests)
    ]
}
#endif
