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
    
    func getFeatureReport(reportSize: Int) {
//        print("get feature report \(reportSize)")
//        var reportSizePointer = reportSize
//        let report = UnsafeMutablePointer<UInt8>.allocate(capacity: reportSize)
//
//        let callback : IOHIDReportCallback = { inContext, inResult, inSender, type, reportId, report, reportLength in
//            let data = Data(bytes: UnsafePointer<UInt8>(report), count: reportLength)
//            print(data)
//            print(String(data: data, encoding: .utf8))
//        }
//
//        let context = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
//        let returnValue = IOHIDDeviceGetReportWithCallback(self, kIOHIDReportTypeFeature, 3, report, &reportSizePointer, 10, callback, context)
//        print(returnValue == kIOReturnUnsupported)
    }
    
    func sendFeatureReport(reportSize: Int, data: Data) {
        print("send feature report \(reportSize)")
        print(String(data: data, encoding: .utf8))
//        let report = [UInt8](data)
//
//        let callback : IOHIDReportCallback = { inContext, inResult, inSender, type, reportId, report, reportLength in
//            let data = Data(bytes: UnsafePointer<UInt8>(report), count: reportLength)
//            print(data)
////            print(String(data: data, encoding: .utf8))
//        }
//
//        let context = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
//        let returnValue = IOHIDDeviceSetReportWithCallback(self, kIOHIDReportTypeFeature, 5, report, reportSize, 10, callback, context)
//        print(returnValue == kIOReturnUnsupported)
    }
    
}
