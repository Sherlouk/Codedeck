//
//  StreamDeckCreateKeyTests.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//

import XCTest
@testable import Codedeck
@testable import HIDSwift

class StreamDeckCreateKeyTests: XCTestCase {

    func testKeyInBounds() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        XCTAssertNoThrow(try streamDeck.key(for: 1))
        XCTAssertNoThrow(try streamDeck.key(for: 5))
        XCTAssertNoThrow(try streamDeck.key(for: 10))
        XCTAssertNoThrow(try streamDeck.key(for: 15))
    }
    
    func testKeyOutOfBounds() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        XCTAssertThrowsErrorMatching(try streamDeck.key(for: 0), error: StreamDeck.Error.keyIndexOutOfRange)
        XCTAssertThrowsErrorMatching(try streamDeck.key(for: 16), error: StreamDeck.Error.keyIndexOutOfRange)
    }
    
    func testKeyMappingCorrectly() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        XCTAssertEqual(try! streamDeck.key(for: 1).keyIndex, 4)
        XCTAssertEqual(try! streamDeck.key(for: 2).keyIndex, 3)
        XCTAssertEqual(try! streamDeck.key(for: 3).keyIndex, 2)
        XCTAssertEqual(try! streamDeck.key(for: 4).keyIndex, 1)
        XCTAssertEqual(try! streamDeck.key(for: 5).keyIndex, 0)
        XCTAssertEqual(try! streamDeck.key(for: 6).keyIndex, 9)
        XCTAssertEqual(try! streamDeck.key(for: 7).keyIndex, 8)
        XCTAssertEqual(try! streamDeck.key(for: 8).keyIndex, 7)
        XCTAssertEqual(try! streamDeck.key(for: 9).keyIndex, 6)
        XCTAssertEqual(try! streamDeck.key(for: 10).keyIndex, 5)
        XCTAssertEqual(try! streamDeck.key(for: 11).keyIndex, 14)
        XCTAssertEqual(try! streamDeck.key(for: 12).keyIndex, 13)
        XCTAssertEqual(try! streamDeck.key(for: 13).keyIndex, 12)
        XCTAssertEqual(try! streamDeck.key(for: 14).keyIndex, 11)
        XCTAssertEqual(try! streamDeck.key(for: 15).keyIndex, 10)
    }
    
    static var allTests = [
        ("testKeyInBounds", testKeyInBounds),
        ("testKeyOutOfBounds", testKeyOutOfBounds),
        ("testKeyMappingCorrectly", testKeyMappingCorrectly)
    ]

}
