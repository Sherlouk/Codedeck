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
    
    // XL is a Gen2 device
    case streamDeckXL
    
    // Public
    
    public func productInformation() -> HIDDeviceMonitor.ProductInformation {
        return .init(vendorId: vendorId, productId: productId)
    }
    
    public var iconSize: Int {
        switch self {
        case .streamDeck: return 72
        case .streamDeckMini: return 80
        case .streamDeckXL: return 96
        }
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
    
    internal var pagePacketSize: Int {
        switch self {
        case .streamDeck: return 8191
        case .streamDeckMini: return 1024
        case .streamDeckXL: return 1024
        }
    }
    
    internal var dataCount: Int {
        switch self {
        case .streamDeck: return 17
        case .streamDeckMini: return 17
        case .streamDeckXL: return 32
        }
    }
    
    internal var isVersionTwo: Bool {
        if case .streamDeckXL = self {
            return true
        }
        
        return false
    }
    
}
