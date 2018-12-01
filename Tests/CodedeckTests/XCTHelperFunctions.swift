//
//  XCTHelperFunctions.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import XCTest

func XCTAssertThrowsErrorMatching<T>(_ expression: @autoclosure () throws -> T, error expectedError: LocalizedError) {
    XCTAssertThrowsError(expression) { error in
        if expectedError.localizedDescription != error.localizedDescription {
            XCTFail("Error thrown but of incorrect type")
        }
    }
}

func XCTAssertDataFromJSON(data: Data, jsonName: String) {
    // This is a highly fragile (and hopefully temporary) solution for obtaining the resources directory
    // suitable when running `swift test`. It fails when run via Xcode. Open to change this!
    
    let currentBundle = Bundle(for: CodedeckTests.self)
    let resourceBundle = Bundle(path: "\(currentBundle.bundlePath)/../../../../Tests/CodedeckTests/Resources")
    
    guard let url = resourceBundle?.url(forResource: jsonName, withExtension: "json") else {
        XCTFail("Failed to locate reference JSON file")
        return
    }
    
    guard let fileData = try? Data(contentsOf: url) else {
        XCTFail("Failed to laod data from JSON file")
        return
    }
    
    guard let referenceBytes = (try? JSONSerialization.jsonObject(with: fileData)) as? [UInt8] else {
        XCTFail("Could not convert file data to JSON")
        return
    }
    
    let actualBytes = [UInt8](data)
    
    guard referenceBytes == actualBytes else {
        XCTFail("Reference bytes is not a match for actual bytes")
        return
    }
    
}
