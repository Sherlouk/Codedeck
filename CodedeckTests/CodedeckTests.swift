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

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        let testDevice = TestDevice()
        var pageNumber: Int = 0
        
        let writeExpectation = expectation(description: "Two pages of content should be written to")
        writeExpectation.expectedFulfillmentCount = 2
        
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
        try! streamDeck.key(for: 0).setColor(red: 255, green: 0, blue: 0)
        
        waitForExpectations(timeout: 0.1, handler: nil)
    }

}

func XCTAssertDataFromJSON(data: Data, jsonName: String) {
    guard let url = Bundle(for: CodedeckTests.self).url(forResource: jsonName, withExtension: "json") else {
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
