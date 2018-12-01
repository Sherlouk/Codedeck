import XCTest

import CodedeckTests

var tests = [XCTestCaseEntry]()
tests += CodedeckTests.allTests()
XCTMain(tests)