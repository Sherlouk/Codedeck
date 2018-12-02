//
//  IOHIDDevice+Write.swift
//  Codedeck
//
//  Created by Sherlock, James on 30/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

extension IOHIDDevice {
    
    public func write(data: Data) {
        IOHIDDeviceSetReport(
            self,
            kIOHIDReportTypeOutput,
            CFIndex(0),
            [UInt8](data),
            data.count
        )
    }
    
}
