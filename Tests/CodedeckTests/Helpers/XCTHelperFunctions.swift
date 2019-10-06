//
//  XCTHelperFunctions.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import XCTest

func XCTAssertThrowsErrorMatching<T>(_ expression: @autoclosure () throws -> T, error expectedError: LocalizedError, file: StaticString = #file, line: UInt = #line) {
}

func XCTAssertDataFromJSON(data: Data, jsonName: String) {
    
    let optionalUrl: URL? = {
        let currentBundle = Bundle(for: StreamDeckSetColorTests.self)
        
        if let url = currentBundle.url(forResource: jsonName, withExtension: "json") {
            return url
        }
        
        let resourceBundle = Bundle(path: "\(currentBundle.bundlePath)/../../../../Tests/CodedeckTests/Resources")
        
        if let url = resourceBundle?.url(forResource: jsonName, withExtension: "json") {
            return url
        }
        
        return nil
    }()
    
    guard let url = optionalUrl else {
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
