//
//  DataConvenienceExtensionsTests.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//

import XCTest
@testable import Codedeck

class DataConvenienceExtensionsTests: XCTestCase {
    
    func testDataPadding() {
        var dataOne = Data(bytes: [0, 0])
        dataOne.pad(toLength: 4)
        
        XCTAssertEqual([UInt8](dataOne), [0, 0, 0, 0])
        
        var dataTwo = Data(bytes: [0, 0, 0, 0])
        dataTwo.pad(toLength: 2)
        
        XCTAssertEqual([UInt8](dataTwo), [0, 0, 0, 0])
        
        var dataThree = Data(bytes: [0, 0, 0, 0])
        dataThree.pad(toLength: 4)
        
        XCTAssertEqual([UInt8](dataThree), [0, 0, 0, 0])
    }
    
    func testDataRepeating() {
        let dataOne = Data(repeating: [0, 1, 2, 3], count: 2)
        XCTAssertEqual([UInt8](dataOne), [0, 1, 2, 3, 0, 1, 2, 3])
        
        let dataTwo = Data(bytes: [0, 1, 2, 3]).repeated(count: 2)
        XCTAssertEqual([UInt8](dataTwo), [0, 1, 2, 3, 0, 1, 2, 3])
    }
    
    static var allTests = [
        ("testDataPadding", testDataPadding),
        ("testDataRepeating", testDataRepeating)
    ]
    
}
