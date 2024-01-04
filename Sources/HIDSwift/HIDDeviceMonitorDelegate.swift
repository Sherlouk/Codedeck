//
//  HIDDeviceMonitorDelegate.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

public protocol HIDDeviceMonitorDelegate: AnyObject {
    func HIDDeviceAdded(device: HIDDevice)
    func HIDDeviceRemoved(device: HIDDevice)
    func HIDDeviceError(error: Error)
}
