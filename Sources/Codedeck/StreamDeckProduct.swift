//
//  StreamDeckProduct.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

#if canImport(HIDSwift)
import HIDSwift
#endif

public enum StreamDeckProduct: CaseIterable {
    
    case streamDeck
    case streamDeckMini
    case streamDeckXL
    
    // Public
    
    public func productInformation() -> HIDDeviceMonitor.ProductInformation {
        return .init(vendorId: vendorId, productId: productId)
    }
    
    public var iconSize: Int {
        return 72
    }
    
    public var keyCount: Int {
        switch self {
        case .streamDeck: return 15 // 5 x 3
        case .streamDeckMini: return 6 // 3 x 2
        case .streamDeckXL: return 32 // 8 x 4
        }
    }
    
    // Internal
    
    internal var vendorId: Int {
        switch self {
        case .streamDeck: return 0x0fd9
        case .streamDeckMini: return 0x0fd9
        case .streamDeckXL: return 0x0fd9
        }
    }
    
    internal var productId: Int {
        switch self {
        case .streamDeck: return 0x0060
        case .streamDeckMini: return 0x0063
        case .streamDeckXL: return 0x006c
        }
    }
    
}
