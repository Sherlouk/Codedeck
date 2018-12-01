//
//  IOHIDManager+Configure.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import IOKit.hid

extension IOHIDManager {
    
    func setDeviceMatchingMultiple(products: [HIDDeviceMonitor.ProductInformation]) {
        var builder = [[String: Any]]()
        
        for product in products {
            builder.append([
                kIOHIDProductIDKey: product.productId,
                kIOHIDVendorIDKey: product.vendorId
            ])
        }
        
        IOHIDManagerSetDeviceMatchingMultiple(self, builder as CFArray)
    }
    
    func scheduleWithRunLoop(with runLoop: CFRunLoop, runLoopMode: CFRunLoopMode = .defaultMode) {
        IOHIDManagerScheduleWithRunLoop(self, runLoop, runLoopMode.rawValue)
    }
    
    func open(options: IOOptionBits = IOOptionBits(kIOHIDOptionsTypeNone)) {
        IOHIDManagerOpen(self, options)
    }
    
    func registerDeviceMatchingCallback(_ callback: @escaping IOHIDDeviceCallback, context: UnsafeMutableRawPointer?) {
        IOHIDManagerRegisterDeviceMatchingCallback(self, callback, context)
    }
    
    func registerDeviceRemovalCallback(_ callback: @escaping IOHIDDeviceCallback, context: UnsafeMutableRawPointer?) {
        IOHIDManagerRegisterDeviceRemovalCallback(self, callback, context)
    }
    
}
