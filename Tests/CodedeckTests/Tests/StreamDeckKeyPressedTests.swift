//
//  StreamDeckKeyPressedTests.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//

import XCTest
@testable import Codedeck
@testable import HIDSwift

class StreamDeckKeyPressedTests: XCTestCase {
    
    func testAllKeysPressed() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        // 1. Validate everything is depressed
        streamDeck.allKeys().forEach({
            XCTAssertFalse($0.isPressed)
        })
        
        // 2. Set everything to pressed
        let dataOne = Data(bytes: [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0])
        streamDeck.receiveDataFromDevice(data: dataOne)
        
        // 3. Validate everything is pressed
        streamDeck.allKeys().forEach({
            XCTAssertTrue($0.isPressed)
        })
        
        // 4. Set everything to depressed
        let dataTwo = Data(bytes: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        streamDeck.receiveDataFromDevice(data: dataTwo)
        
        // 5. Validate everything is depressed
        streamDeck.allKeys().forEach({
            XCTAssertFalse($0.isPressed)
        })
    }
    
    func testInvalidKeyPressData() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        // 1. Validate everything is depressed
        streamDeck.allKeys().forEach({
            XCTAssertFalse($0.isPressed)
        })
        
        // 2. Set everything to pressed
        let dataOne = Data(bytes: [0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0])
        streamDeck.receiveDataFromDevice(data: dataOne)
        
        // 3. Validate everything is pressed
        streamDeck.allKeys().forEach({
            XCTAssertTrue($0.isPressed)
        })
        
        // 4. Send invalid data size to method
        let dataTwo = Data(bytes: [0, 0, 0, 0, 0])
        streamDeck.receiveDataFromDevice(data: dataTwo)
        
        // 5. Validate everything is still pressed
        streamDeck.allKeys().forEach({
            XCTAssertTrue($0.isPressed)
        })
    }
    
    func testCorrectKeyMapping() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        func validateSingleKeyDown(keyIndex: Int) {
            streamDeck.allKeys().forEach({
                if $0.keyIndex == keyIndex {
                    XCTAssertTrue($0.isPressed)
                } else {
                    XCTAssertFalse($0.isPressed)
                }
            })
        }
        
        // 1. Validate all keys are depressed
        validateSingleKeyDown(keyIndex: -1)
        
        // 2. Set key 0 to pressed, everything else to depressed
        let dataOne = Data(bytes: [0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        streamDeck.receiveDataFromDevice(data: dataOne)
        validateSingleKeyDown(keyIndex: 0)
        
        // 3. Set key 5 to pressed, everything else to depressed
        let dataTwo = Data(bytes: [0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])
        streamDeck.receiveDataFromDevice(data: dataTwo)
        validateSingleKeyDown(keyIndex: 5)
        
        // 4. Set key 10 to pressed, everything else to depressed
        let dataThree = Data(bytes: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0])
        streamDeck.receiveDataFromDevice(data: dataThree)
        validateSingleKeyDown(keyIndex: 10)
        
        // 5. Set key 15 to pressed, everything else to depressed
        let dataFour = Data(bytes: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0])
        streamDeck.receiveDataFromDevice(data: dataFour)
        validateSingleKeyDown(keyIndex: 14)
    }
    
    static var allTests = [
        ("testAllKeysPressed", testAllKeysPressed),
        ("testInvalidKeyPressData", testInvalidKeyPressData),
        ("testCorrectKeyMapping", testCorrectKeyMapping)
    ]

}
