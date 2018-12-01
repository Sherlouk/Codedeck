//
//  RawDeviceProtocols.swift
//  Codedeck
//
//  Created by Sherlock, James on 30/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import IOKit.hid

public protocol ReadDevice {
    func registerInputReportCallback(reportSize: Int, callback: @escaping IOHIDReportCallback, context: UnsafeMutableRawPointer?)
}

public protocol WriteDevice {
    func write(data: Data)
}

public protocol FeatureReportDevice {
    func getFeatureReport(reportSize: Int)
    func sendFeatureReport(reportSize: Int, data: Data)
}

extension IOHIDDevice: ReadDevice, WriteDevice, FeatureReportDevice {}
