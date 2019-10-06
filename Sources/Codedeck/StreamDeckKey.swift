//
//  StreamDeckKey.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import CoreGraphics

public class StreamDeckKey {
    
    enum Error: Swift.Error, LocalizedError {
        case rgbValueOutOfRange(value: Int)
        
        var errorDescription: String? {
            switch self {
            case .rgbValueOutOfRange(let value):
                return "RGB value was out of bounds (>= 0 and <= 255 was \(value))"
            }
        }
    }
    
    let streamDeck: StreamDeck
    let keyIndex: Int
    
    internal init(streamDeck: StreamDeck, keyIndex: Int) {
        self.streamDeck = streamDeck
        self.keyIndex = keyIndex
    }
    
    // Public
    
    public var isPressed: Bool {
        return streamDeck.keysPressed[keyIndex] == true
    }
    
    public func clear() throws {
        try setColor(red: 0, green: 0, blue: 0)
    }
    
    static let NUM_FIRST_PAGE_PIXELS = 2583
    static let NUM_SECOND_PAGE_PIXELS = 2601
    
    public func setColor(red: Int, green: Int, blue: Int) throws {
        try assertRGBValue(red)
        try assertRGBValue(green)
        try assertRGBValue(blue)
        
        let bytes: [UInt8] = [blue, green, red].map({ UInt8($0) })
        let data = Data(bytes)
        
        switch streamDeck.product {
        case .streamDeck:
            let firstPage = streamDeck.dataPageOne(keyIndex: keyIndex, data: data.repeated(count: StreamDeckKey.NUM_FIRST_PAGE_PIXELS))
            streamDeck.write(data: firstPage)
            
            let secondPage = streamDeck.dataPageTwo(keyIndex: keyIndex, bufIndex: 0, data: data.repeated(count: StreamDeckKey.NUM_SECOND_PAGE_PIXELS))
            streamDeck.write(data: secondPage)
        case .streamDeckMini:
            let pageOnePacketSize = streamDeck.product.pagePacketSize - 70
            let pageTwoPacketSize = streamDeck.product.pagePacketSize - 16
            let iconBytes = 80 * 80 * 3
            
            let firstPage = streamDeck.dataPageOne(keyIndex: keyIndex, data: data.repeated(count: pageOnePacketSize / 3))
            streamDeck.write(data: firstPage)
            
            var count = 0
            var i = pageOnePacketSize
            while i < iconBytes {
                count += 1
                let data = data.repeated(count: min(pageTwoPacketSize, iconBytes-i) / 3)
                let secondPage = streamDeck.dataPageTwo(keyIndex: keyIndex, bufIndex: count, data: data)
                streamDeck.write(data: secondPage)
                i += pageTwoPacketSize
            }
        }
        
    }
    
    public func setImage(withActions actions: (CGContext, CGSize) -> Void) {
        let contextSize = CGSize(width: streamDeck.product.iconSize, height: streamDeck.product.iconSize)
        
        guard let context = CGContext(data: nil, width: Int(contextSize.width), height: Int(contextSize.height), bitsPerComponent: 8, bytesPerRow: 0, space: CGColorSpaceCreateDeviceRGB(), bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
            fatalError("Could not create a context for StreamDeck")
        }
        
        context.setFillColor(.black)
        context.fill(CGRect(origin: .zero, size: contextSize))
        
        actions(context, contextSize)
        
        guard let rawPointer = context.data else {
            fatalError("Could not get data for the context")
        }
        
        let numberOfBytes = context.height * context.bytesPerRow
        
        let buffer = UnsafeBufferPointer(start: rawPointer.bindMemory(to: UInt8.self, capacity: numberOfBytes), count: numberOfBytes)
        let imageData = Data(buffer: buffer)
        
        let firstPageImageData = imageData[0 ..< StreamDeckKey.NUM_FIRST_PAGE_PIXELS]
        let secondPageImageData = imageData[StreamDeckKey.NUM_FIRST_PAGE_PIXELS ..< StreamDeckKey.NUM_FIRST_PAGE_PIXELS + StreamDeckKey.NUM_SECOND_PAGE_PIXELS]
        
        let firstPage = streamDeck.dataPageOne(keyIndex: keyIndex, data: firstPageImageData)
        let secondPage = streamDeck.dataPageTwo(keyIndex: keyIndex, bufIndex: 0, data: secondPageImageData)
        
        streamDeck.write(data: firstPage)
        streamDeck.write(data: secondPage)
    }
    
    // Private
    
    private func assertRGBValue(_ value: Int) throws {
        guard (0...255).contains(value) else {
            throw Error.rgbValueOutOfRange(value: value)
        }
    }
    
}
