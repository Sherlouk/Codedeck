//
//  IOHIDDevice+FeatureReport.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import IOKit.hid

extension IOHIDDevice {
    
    // WIP
    
    public func getFeatureReport(reportSize: Int) {
        // This is currently unoperational and returns `kIOReturnUnsupported` for an unknown reason
        
        let callback: IOHIDReportCallback = { _, _, _, _, _, _, _ in
            print("callback")
        }
        
        let reportId: UInt8 = 3
        var report: UInt8 = 0
        var reportSize: CFIndex = 17
        
        let context = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        let returnValue = IOHIDDeviceGetReportWithCallback(
            self,
            kIOHIDReportTypeFeature,
            CFIndex(reportId),
            &report,
            &reportSize,
            10, // timeout
            callback,
            context
        )
        
        print(IOReturnMapper(rawValue: returnValue) as Any)
    }
    
    public func sendFeatureReport(data: Data) {
        IOHIDDeviceSetReport(
            self,
            kIOHIDReportTypeFeature,
            CFIndex(data[0]),
            [UInt8](data),
            data.count
        )
    }
    
}
