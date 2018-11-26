//
//  StreamDeck.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

public class StreamDeck {
    
    public enum Error: Swift.Error {
        case keyIndexOutOfRange
        case brightnessOutOfRange
    }
    
    let device: HIDDevice
    let product: StreamDeckProduct
    var keysPressed = [Int: Bool]()
    
    public init(device: HIDDevice) throws {
        self.device = device
        self.product = try device.makeStreamDeckProduct()
        
        device.startReading(callback: receiveDataFromDevice(data:))
    }
    
    // Public
    
    public func setBrightness(_ brightness: Int) throws {
        guard (0...100).contains(brightness) else {
            throw Error.brightnessOutOfRange
        }
        
        // TODO
        let bytes: [UInt8] = [0x05, 0x55, 0xaa, 0xd1, 0x01, UInt8(brightness)]
        let data = padData(data: Data(bytes: bytes), to: device.reportSize)
        
        device.sendFeatureReport(data: data)
        Logger.success("Set Brightness to \(brightness)%")
    }
    
    public func clearAllKeys() throws {
        try allKeys().forEach {
            try $0.clear()
        }
    }
    
    public func key(for index: Int) throws -> StreamDeckKey {
        try assertKeyInRange(index)
        return StreamDeckKey(streamDeck: self, keyIndex: index)
    }
    
    public func allKeys() -> [StreamDeckKey] {
        return keysRange().map({
            StreamDeckKey(streamDeck: self, keyIndex: $0)
        })
    }
    
    // Private
    
    private func keysRange() -> Range<Int> {
        return 0 ..< product.keyCount
    }
    
    private func assertKeyInRange(_ key: Int) throws {
        guard keysRange().contains(key) else {
            throw Error.keyIndexOutOfRange
        }
    }
    
    // Reading
    
    private func receiveDataFromDevice(data: Data) {
        guard data.count == product.keyCount + 2 else {
            Logger.error("Data received from device was not correct size (\(data.count) != \(product.keyCount + 2))")
            return
        }
        
        // The first byte is the report ID
        // The last byte appears to be padding
        // We'll ignore these for now, the count should be equal to the key count.
        let keyData = data[1 ..< (data.count - 1)]
        
        for (keyIndex, keyValue) in keyData.enumerated() {
            keysPressed[keyIndex] = keyValue == 1
        }
        
        let currentKeysPressed = keysPressed.filter({ $0.value })
            
        if currentKeysPressed.isEmpty {
            Logger.info("No Keys Pressed")
        } else {
            let keysPressedDescription = currentKeysPressed.map({ String($0.key) }).joined(separator: ", ")
            Logger.info("Keys Pressed: \(keysPressedDescription)")
        }
        
    }
    
    private func padData(data: Data, to length: Int) -> Data {
        var mutableData = data
        let padLength = length - data.count
        
        if padLength < 0 {
            Logger.error("Trying to pad data of length \(data.count) to \(length)")
            return data
        } else if padLength == 0 {
            return data
        }
        
        mutableData.append(contentsOf: [UInt8](repeating: 0, count: padLength))
        return mutableData
    }
    
}
