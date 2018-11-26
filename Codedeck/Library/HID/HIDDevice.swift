//
//  HIDDevice.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import IOKit.hid

public class HIDDevice {
    
    public typealias ReadingCallback = (Data) -> ()
    
    /// Unique identifier of Device, dynamic
    public let id: Int
    
    /// Name of the Device (e.g: "Stream Deck")
    public let name: String
    
    /// Device Vendor Identifier
    public let vendorId: Int
    
    /// Device Product Identifier
    public let productId: Int
    
    /// Report Size of Data
    public let reportSize: Int
    
    /// Serial Number of the Device, persistant
    public let serialNumber: String
    
    /// Reference back to raw IOKit Device
    public let device: IOHIDDevice
    
    /// Callback used to obtain data in realtime from the device
    internal var readingCallback: ReadingCallback?
    
    init(device: IOHIDDevice) throws {
        self.device = device
        
        id = try device.getProperty(key: kIOHIDLocationIDKey)
        name = try device.getProperty(key: kIOHIDProductKey)
        vendorId = try device.getProperty(key: kIOHIDVendorIDKey)
        productId = try device.getProperty(key: kIOHIDProductIDKey)
        reportSize = try device.getProperty(key: kIOHIDMaxInputReportSizeKey)
        serialNumber = try device.getProperty(key: kIOHIDSerialNumberKey)
    }
    
    var description: String {
        return """
        HIDDevice (\(name) - \(serialNumber)):
            ID: \(id)
            Vendor ID: \(vendorId)
            Product ID: \(productId)
            Report Size: \(reportSize)
        """
    }
    
}
