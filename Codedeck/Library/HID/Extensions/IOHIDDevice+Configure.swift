//
//  IOHIDDevice+Configure.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import IOKit.hid

extension IOHIDDevice {
    
    public func registerInputReportCallback(reportSize: Int, callback: @escaping IOHIDReportCallback, context: UnsafeMutableRawPointer?) {
        let report = UnsafeMutablePointer<UInt8>.allocate(capacity: reportSize)
        IOHIDDeviceRegisterInputReportCallback(self, report, reportSize, callback, context)
    }
    
}
