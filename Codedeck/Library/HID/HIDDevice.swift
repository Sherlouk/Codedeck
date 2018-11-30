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
    
    internal init(device: IOHIDDevice) throws {
        self.device = device
        
        id = try device.getProperty(key: kIOHIDLocationIDKey)
        name = try device.getProperty(key: kIOHIDProductKey)
        vendorId = try device.getProperty(key: kIOHIDVendorIDKey)
        productId = try device.getProperty(key: kIOHIDProductIDKey)
        reportSize = try device.getProperty(key: kIOHIDMaxInputReportSizeKey)
        serialNumber = try device.getProperty(key: kIOHIDSerialNumberKey)
    }
    
    /// Basic description of the device with all parameters listed
    public var description: String {
        return """
        HIDDevice (\(name) - \(serialNumber)):
            ID: \(id)
            Vendor ID: \(vendorId)
            Product ID: \(productId)
            Report Size: \(reportSize)
        """
    }
    
    public func getFeatureReport(callback: () -> ()) {
        device.getFeatureReport(reportSize: reportSize)
    }
    
    public func sendFeatureReport(data: Data) {
        device.sendFeatureReport(reportSize: reportSize, data: data)
    }
    
    // Block to enable overridding from tests
    internal var writeBlock: (Data) -> () = { _ in 
        // TODO https://github.com/Arti3DPlayer/USBDeviceSwift/blob/master/RaceflightControllerHIDExample/RaceflightControllerHIDExample/RFDevice.swift#L26
    }
    
    public func write(data: Data) {
        
        print(data.count)
        writeBlock(data)
    }
    
}
