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
    
    // MARK: - Definitions
    
    public typealias ReadingCallback = (Data) -> ()
    public typealias RawDevice = ReadDevice & WriteDevice & FeatureReportDevice
    
    // MARK: - Variables
    
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
    public let device: RawDevice
    
    /// Callback used to obtain data in realtime from the device
    internal var readingCallback: ReadingCallback?
    
    // MARK: - Initialisation
    
    /// Create a HIDDevice with a system IOHIDDevice
    internal init(device: IOHIDDevice) throws {
        self.device = device
        
        id = try device.getProperty(key: kIOHIDLocationIDKey)
        name = try device.getProperty(key: kIOHIDProductKey)
        vendorId = try device.getProperty(key: kIOHIDVendorIDKey)
        productId = try device.getProperty(key: kIOHIDProductIDKey)
        reportSize = try device.getProperty(key: kIOHIDMaxInputReportSizeKey)
        serialNumber = try device.getProperty(key: kIOHIDSerialNumberKey)
    }
    
    /// Creates a HIDDevice from individual information primarily used by testing
    internal init(id: Int, name: String, vendorId: Int, productId: Int, reportSize: Int, serialNumber: String, device: RawDevice) {
        self.id = id
        self.name = name
        self.vendorId = vendorId
        self.productId = productId
        self.reportSize = reportSize
        self.serialNumber = serialNumber
        self.device = device
    }
    
    // MARK: - Description
    
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
    
    // MARK: - Public
    
    public func getFeatureReport(callback: () -> ()) {
        device.getFeatureReport(reportSize: reportSize)
    }
    
    public func sendFeatureReport(data: Data) {
        device.sendFeatureReport(reportSize: reportSize, data: data)
    }
    
    public func write(data: Data) {
        device.write(data: data)
    }
    
    public func startReading(callback: @escaping ReadingCallback) {
        self.readingCallback = callback
        
        let inputCallback: IOHIDReportCallback = { inContext, inResult, inSender, type, reportId, report, reportLength in
            let this = unsafeBitCast(inContext, to: HIDDevice.self)
            this.read(reportId: reportId, report: report, reportLength: reportLength)
        }
        
        let context = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        device.registerInputReportCallback(reportSize: reportSize, callback: inputCallback, context: context)
    }
    
    // MARK: - Private
    
    private func read(reportId: UInt32, report: UnsafeMutablePointer<UInt8>, reportLength: CFIndex) {
        let data = Data(bytes: UnsafePointer<UInt8>(report), count: reportLength)
        readingCallback?(data)
    }
    
}
