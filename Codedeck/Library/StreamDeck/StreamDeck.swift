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
    
    public init(device: HIDDevice) throws {
        self.device = device
        self.product = try device.makeStreamDeckProduct()
    }
    
    // Public
    
    public func setBrightness(_ brightness: Int) throws {
        guard (0...100).contains(brightness) else {
            throw Error.brightnessOutOfRange
        }
        
        // TODO
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
    
}
