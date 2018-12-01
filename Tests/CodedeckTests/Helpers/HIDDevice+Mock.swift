//
//  HIDDevice+Mock.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//

import Foundation
@testable import HIDSwift
@testable import Codedeck

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
