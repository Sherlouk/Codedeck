//
//  XCTHelperFunctions.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import XCTest

func XCTAssertThrowsErrorMatching<T>(_ expression: @autoclosure @escaping () throws -> T, error expectedError: LocalizedError, file: StaticString = #file, line: UInt = #line) {
    do {
        _ = try expression()
        XCTFail("Error was not thrown", file: file, line: line)
    } catch {
        if expectedError.localizedDescription != error.localizedDescription {
            XCTFail("Error thrown but of incorrect type", file: file, line: line)
        }
    }
}

func XCTAssertDataFromJSON(data: Data, jsonName: String, file: StaticString = #file, line: UInt = #line) {
    guard let url = Bundle.module.url(forResource: jsonName, withExtension: "json", subdirectory: "Resources") else {
        XCTFail("Failed to locate reference JSON file", file: file, line: line)
        return
    }
    
    guard let fileData = try? Data(contentsOf: url) else {
        XCTFail("Failed to load data from JSON file", file: file, line: line)
        return
    }
    
    guard let referenceBytes = (try? JSONSerialization.jsonObject(with: fileData)) as? [UInt8] else {
        XCTFail("Could not convert file data to JSON", file: file, line: line)
        return
    }
    
    let actualBytes = [UInt8](data)
    
    guard referenceBytes == actualBytes else {
        XCTFail("Reference bytes is not a match for actual bytes", file: file, line: line)
        return
    }
    
}
