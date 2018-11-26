//
//  ViewController.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    var monitor: HIDDeviceMonitor = {
        return HIDDeviceMonitor(streamDeckProducts: [.streamDeck, .streamDeckMini])
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        monitor.startMonitoring(delegate: self)
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
            try streamDeck.setBrightness(50)
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
