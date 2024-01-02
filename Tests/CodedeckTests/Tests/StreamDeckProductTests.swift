//
//  StreamDeckProductTests.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import XCTest
@testable import Codedeck
@testable import HIDSwift

class StreamDeckProductTests: XCTestCase {
    
    func testProductId() {
        XCTAssertEqual(StreamDeckProduct.streamDeck.productId, 0x0060)
        XCTAssertEqual(StreamDeckProduct.streamDeckMini.productId, 0x0063)
    }
    
    func testVendorId() {
        XCTAssertEqual(StreamDeckProduct.streamDeck.vendorId, 0x0fd9)
        XCTAssertEqual(StreamDeckProduct.streamDeckMini.vendorId, 0x0fd9)
    }
    
    func testIconSize() {
        XCTAssertEqual(StreamDeckProduct.streamDeck.iconSize, 72)
        XCTAssertEqual(StreamDeckProduct.streamDeckMini.iconSize, 80)
    }
    
    func testKeyCount() {
        XCTAssertEqual(StreamDeckProduct.streamDeck.keyCount, 15)
        XCTAssertEqual(StreamDeckProduct.streamDeckMini.keyCount, 6)
    }
    
    func testProductInformation() {
        XCTAssertEqual(StreamDeckProduct.streamDeck.productInformation().productId, 0x0060)
        XCTAssertEqual(StreamDeckProduct.streamDeck.productInformation().vendorId, 0x0fd9)
        XCTAssertEqual(StreamDeckProduct.streamDeckMini.productInformation().productId, 0x0063)
        XCTAssertEqual(StreamDeckProduct.streamDeckMini.productInformation().vendorId, 0x0fd9)
    }
    
    func testInvalidProduct() {
        let testDevice = HIDDevice(
            id: 0,
            name: "Not a Stream Deck",
            vendorId: 0,
            productId: 0,
            reportSize: 17,
            serialNumber: "abcdef",
            device: TestDevice()
        )
        
        XCTAssertThrowsErrorMatching(try testDevice.makeStreamDeckProduct(), error: HIDDevice.Error.notStreamDeckProduct)
    }
    
    func testCaseIterable() {
        // This test is primarily a way to force an error should we ever add other products
        XCTAssertEqual(StreamDeckProduct.allCases, [.streamDeck, .streamDeckMini, .streamDeckXL])
    }
}
