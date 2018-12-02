//
//  ViewController.swift
//  Codedeck
//
//  Created by Sherlock, James on 01/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Cocoa
import Codedeck

class ViewController: NSViewController {

    var monitor: HIDDeviceMonitor = {
        return HIDDeviceMonitor(streamDeckProducts: [.streamDeck])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        monitor.startMonitoring(delegate: self)
        print("Started Monitoring")
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

}

extension ViewController: HIDDeviceMonitorDelegate {
    
    func HIDDeviceAdded(device: HIDDevice) {
        do {
            print(device.description)
            
            let streamDeck = try StreamDeck(device: device)
//            try streamDeck.setBrightness(50)
            try streamDeck.clearAllKeys()
            try streamDeck.key(for: 0).setColor(color: .blue)
            try streamDeck.key(for: 1).setColor(color: .green)
            try streamDeck.key(for: 2).setColor(color: .red)
            try streamDeck.key(for: 3).setColor(color: .purple)
            try streamDeck.key(for: 4).setColor(color: .orange)
            
//            streamDeck.device.getFeatureReport {
//                print("report")
//            }
        } catch {
            print(error)
        }
    }
    
    func HIDDeviceRemoved(device: HIDDevice) {
        print(device.description)
    }
    
    func HIDDeviceError(error: Error) {
        print(error)
    }
    
}
