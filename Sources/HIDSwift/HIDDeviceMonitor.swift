//
//  HIDDeviceMonitor.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

public class HIDDeviceMonitor {
    
    public struct ProductInformation {
        public let vendorId: Int
        public let productId: Int
        
        public init(vendorId: Int, productId: Int) {
            self.vendorId = vendorId
            self.productId = productId
        }
    }
    
    // Variables
    
    private let products: [ProductInformation]
    private var monitoringThread: Thread?
    private weak var delegate: HIDDeviceMonitorDelegate?
    public var knownDevices = [String: HIDDevice]()
    
    // Lifecycle
    
    public init(searchableProducts: [ProductInformation]) {
        self.products = searchableProducts
    }
    
    deinit {
        stopMonitoring()
    }
    
    // Public
    
    /// Starts watching out for devices on new thread.
    /// Delegate receives device connection/disconnection events.
    public func startMonitoring(delegate: HIDDeviceMonitorDelegate) {
        self.delegate = delegate
        
        monitoringThread = Thread(target: self, selector: #selector(start), object: nil)
        monitoringThread?.start()
    }
    
    /// Stops watching out for devices and cleans up thread.
    public func stopMonitoring() {
        monitoringThread?.cancel()
        monitoringThread = nil
        delegate = nil
    }
    
    // Internal
    
    @objc func start() {
        let manager = IOHIDManagerCreate(kCFAllocatorDefault, IOOptionBits(kIOHIDOptionsTypeNone))
        manager.setDeviceMatchingMultiple(products: products)
        manager.scheduleWithRunLoop(with: CFRunLoopGetCurrent())
        manager.open()
        
        let matchingCallback: IOHIDDeviceCallback = { inContext, _, _, device in
            let this = unsafeBitCast(inContext, to: HIDDeviceMonitor.self)
            this.rawDeviceAdded(rawDevice: device)
        }
        
        let removalCallback: IOHIDDeviceCallback = { inContext, _, _, device in
            let this = unsafeBitCast(inContext, to: HIDDeviceMonitor.self)
            this.rawDeviceRemoved(rawDevice: device)
        }
        
        let context = unsafeBitCast(self, to: UnsafeMutableRawPointer.self)
        manager.registerDeviceMatchingCallback(matchingCallback, context: context)
        manager.registerDeviceRemovalCallback(removalCallback, context: context)
        
        RunLoop.current.run()
    }
    
    func rawDeviceAdded(rawDevice: IOHIDDevice) {
        do {
            let device = try HIDDevice(device: rawDevice)
            knownDevices[device.serialNumber] = device
            delegate?.HIDDeviceAdded(device: device)
        } catch {
            delegate?.HIDDeviceError(error: error)
        }
    }
    
    func rawDeviceRemoved(rawDevice: IOHIDDevice) {
        do {
            let device = try HIDDevice(device: rawDevice)
            knownDevices[device.serialNumber] = nil
            delegate?.HIDDeviceRemoved(device: device)
        } catch {
            delegate?.HIDDeviceError(error: error)
        }
    }
    
}
