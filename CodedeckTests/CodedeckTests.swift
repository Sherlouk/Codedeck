//
//  CodedeckTests.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import XCTest
@testable import Codedeck

class CodedeckTests: XCTestCase {
    
    func testSetColorRed() {
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
        let streamDeck = try! StreamDeck(device: device)
        XCTAssertNoThrow(try streamDeck.key(for: 0).setColor(red: 255, green: 0, blue: 0))
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }
    
    func testSetColorOutOfBounds() {
        let device = HIDDevice.makeMockStreamDeck(rawDevice: TestDevice())
        let streamDeck = try! StreamDeck(device: device)
        
        let key = try! streamDeck.key(for: 0)
        let error = StreamDeckKey.Error.rgbValueOutOfRange(value: 300)
        
        XCTAssertThrowsErrorMatching(try key.setColor(red: 300, green: 0, blue: 0), error: error)
        XCTAssertThrowsErrorMatching(try key.setColor(red: 0, green: 300, blue: 0), error: error)
        XCTAssertThrowsErrorMatching(try key.setColor(red: 0, green: 0, blue: 300), error: error)
    }
    
}

extension HIDDevice {
    
    class func makeMockStreamDeck(product: StreamDeckProduct = .streamDeck, rawDevice: RawDevice) -> HIDDevice {
        return HIDDevice(
            id: 0,
            name: "Stream Deck",
            vendorId: product.vendorId,
            productId: product.productId,
            reportSize: 17,
            serialNumber: "abcdef",
            device: rawDevice
        )
    }
    
}

class TestDevice: ReadDevice, WriteDevice, FeatureReportDevice {
    
    var writeBlock: ((Data) -> ())?
    
    func registerInputReportCallback(reportSize: Int, callback: @escaping IOHIDReportCallback, context: UnsafeMutableRawPointer?) {
        
    }
    
    func getFeatureReport(reportSize: Int) {
        
    }
    
    func sendFeatureReport(reportSize: Int, data: Data) {
        print([UInt8](data))
        print([0x05, 0x55, 0xaa, 0xd1, 0x01, 100] as [UInt8])
    }
    
    func write(data: Data) {
        writeBlock?(data)
    }
    
}
