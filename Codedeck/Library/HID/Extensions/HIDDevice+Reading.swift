//
//  HIDDevice+Reading.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

extension HIDDevice {
    
    public func startReading(callback: @escaping ReadingCallback) {
        self.readingCallback = callback
        
        let inputCallback : IOHIDReportCallback = { inContext, inResult, inSender, type, reportId, report, reportLength in
            let this = unsafeBitCast(inContext, to: HIDDevice.self)
            this.read(reportId: reportId, report: report, reportLength: reportLength)
        }
        
        let context = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        device.registerInputReportCallback(reportSize: reportSize, callback: inputCallback, context: context)
    }
    
    private func read(reportId: UInt32, report: UnsafeMutablePointer<UInt8>, reportLength: CFIndex) {
        let data = Data(bytes: UnsafePointer<UInt8>(report), count: reportLength)
        readingCallback?(data)
    }
    
}
