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
        
        XCTAssertNoThrow(try streamDeck.key(for: 0))
        XCTAssertNoThrow(try streamDeck.key(for: 5))
        XCTAssertNoThrow(try streamDeck.key(for: 10))
        XCTAssertNoThrow(try streamDeck.key(for: 14))
    }
    
    func testKeyOutOfBounds() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        XCTAssertThrowsErrorMatching(try streamDeck.key(for: -1), error: StreamDeck.Error.keyIndexOutOfRange)
        XCTAssertThrowsErrorMatching(try streamDeck.key(for: 15), error: StreamDeck.Error.keyIndexOutOfRange)
    }
    
    static var allTests = [
        ("testKeyInBounds", testKeyInBounds),
        ("testKeyOutOfBounds", testKeyOutOfBounds)
    ]

}
