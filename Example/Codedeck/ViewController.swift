//
//  ViewController.swift
//  Codedeck
//
//  Created by Sherlock, James on 01/12/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Cocoa
import Codedeck
import HIDSwift

class ViewController: NSViewController {

    var monitor: HIDDeviceMonitor = {
        return HIDDeviceMonitor(streamDeckProducts: StreamDeckProduct.allCases)
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
            try streamDeck.clearAllKeys()
            
            try streamDeck.allKeys().forEach({
                try $0.setColor(
                    red: Int.random(in: 0...255),
                    green: Int.random(in: 0...255),
                    blue: Int.random(in: 0...255)
                )
            })
            
            try streamDeck.key(for: 1).setColor(color: .red)
            
            if #available(macOS 11.0, *) {
                try streamDeck.key(for: 2).setImage { context, size in
                    guard let image = NSImage(named: "icon")?.cgImage(forProposedRect: nil, context: nil, hints: nil) else {
                        return
                    }
                    
                    context.draw(image, in: .init(origin: .zero, size: size), byTiling: false)
                }
            }
            
            try streamDeck.setBrightness(50)
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
