//
//  StreamDeckKey.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

public class StreamDeckKey {
    
    enum Error: Swift.Error {
        case rgbValueOutOfRange
    }
    
    let streamDeck: StreamDeck
    let keyIndex: Int
    
    internal init(streamDeck: StreamDeck, keyIndex: Int) {
        self.streamDeck = streamDeck
        self.keyIndex = keyIndex
    }
    
    // Public
    
    public func clear() throws {
        try setColor(red: 0, green: 0, blue: 0)
    }
    
    public func setColor(red: Int, green: Int, blue: Int) throws {
        try assertRGBValue(red)
        try assertRGBValue(green)
        try assertRGBValue(blue)
        
        // TODO
    }
    
    // Private
    
    private func assertRGBValue(_ value: Int) throws {
        guard (0...255).contains(value) else {
            throw Error.rgbValueOutOfRange
        }
    }
    
}
