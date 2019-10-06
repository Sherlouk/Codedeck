//
//  HIDDeviceMonitor+StreamDeckProducts.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

#if canImport(HIDSwift)
import HIDSwift
#endif

public extension HIDDeviceMonitor {
    
    convenience init(streamDeckProducts: [StreamDeckProduct] = StreamDeckProduct.allCases) {
        self.init(searchableProducts: streamDeckProducts.map({ $0.productInformation() }))
    }
    
}
