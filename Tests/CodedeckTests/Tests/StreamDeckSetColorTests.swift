//
//  StreamDeckSetColorTests.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import XCTest
@testable import Codedeck
@testable import HIDSwift

class StreamDeckSetColorTests: XCTestCase {
    
    func testSetColorRed() throws {
        let writeExpectation = expectation(description: "Two pages of content should be written to")
        writeExpectation.expectedFulfillmentCount = 2
        
        var pageNumber: Int = 0
        
        let testDevice = TestDevice()
        testDevice.writeBlock = { data in
            switch pageNumber {
            case 0:
                XCTAssertDataFromJSON(data: data, jsonName: "fillColor-red-keyOne-pageOne")
            case 1:
                XCTAssertDataFromJSON(data: data, jsonName: "fillColor-red-keyOne-pageTwo")
            default:
                XCTFail("Unrecognised page number")
            }
            
            pageNumber += 1
            writeExpectation.fulfill()
        }
        
        let device = HIDDevice.makeMockStreamDeck(rawDevice: testDevice)
        let streamDeck = try StreamDeck(device: device)
        XCTAssertNoThrow(try streamDeck.key(for: 4).setColor(red: 255, green: 0, blue: 0))
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testClearKey() throws {
        let writeExpectation = expectation(description: "Two pages of content should be written to")
        writeExpectation.expectedFulfillmentCount = 2
        
        var pageNumber: Int = 0
        
        let testDevice = TestDevice()
        testDevice.writeBlock = { data in
            switch pageNumber {
            case 0:
                XCTAssertDataFromJSON(data: data, jsonName: "fillColor-clear-keyOne-pageOne")
            case 1:
                XCTAssertDataFromJSON(data: data, jsonName: "fillColor-clear-keyOne-pageTwo")
            default:
                XCTFail("Unrecognised page number")
            }
            
            pageNumber += 1
            writeExpectation.fulfill()
        }
        
        let device = HIDDevice.makeMockStreamDeck(rawDevice: testDevice)
        let streamDeck = try StreamDeck(device: device)
        XCTAssertNoThrow(try streamDeck.key(for: 4).clear())
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testSetColorOutOfBounds() throws {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try StreamDeck(device: device)
        
        let key = try streamDeck.key(for: 1)
        let errorOne = StreamDeckKey.Error.rgbValueOutOfRange(value: 300)
        let errorTwo = StreamDeckKey.Error.rgbValueOutOfRange(value: -1)
        
        XCTAssertThrowsErrorMatching(try key.setColor(red: 300, green: 0, blue: 0), error: errorOne)
        XCTAssertThrowsErrorMatching(try key.setColor(red: 0, green: 300, blue: 0), error: errorOne)
        XCTAssertThrowsErrorMatching(try key.setColor(red: 0, green: 0, blue: 300), error: errorOne)
        
        XCTAssertThrowsErrorMatching(try key.setColor(red: -1, green: 0, blue: 0), error: errorTwo)
        XCTAssertThrowsErrorMatching(try key.setColor(red: 0, green: -1, blue: 0), error: errorTwo)
        XCTAssertThrowsErrorMatching(try key.setColor(red: 0, green: 0, blue: -1), error: errorTwo)
    }
    
}
