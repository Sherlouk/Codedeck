//
//  StreamDeck.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

#if canImport(HIDSwift)
import HIDSwift
#endif

public class StreamDeck {
    
    public enum Error: Swift.Error, LocalizedError {
        case keyIndexOutOfRange
        case brightnessOutOfRange
        
        public var localizedDescription: String {
            switch self {
            case .keyIndexOutOfRange: return "Key Index out of bounds"
            case .brightnessOutOfRange: return "Brightness out of bounds"
            }
        }
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
    
    /// Sets the brightness of the entire panel
    ///
    /// Brightness should be between 0 and 100
    ///
    /// You can not set the brightness of an individual key
    public func setBrightness(_ brightness: Int) throws {
        guard (0...100).contains(brightness) else {
            throw Error.brightnessOutOfRange
        }
        
        let bytes: [UInt8]
        if product.isVersionTwo {
            bytes = [0x03, 0x08, UInt8(brightness)]
        } else {
            bytes = [0x05, 0x55, 0xaa, 0xd1, 0x01, UInt8(brightness)]
        }
        
        var data = Data(bytes)
        data.pad(toLength: product.dataCount) // 17 (v1) or 32 (v2)
        
        device.sendFeatureReport(data: data)
        Logger.success("Set Brightness to \(brightness)%")
    }
    
    /// Shows the default Elgato logo spread across the keys
    public func reset() {
        let bytes: [UInt8]
        if product.isVersionTwo {
            bytes = [0x03, 0x02] // v2
        } else {
            bytes = [0x0B, 0x63] // v1
        }
        
        var data = Data(bytes)
        data.pad(toLength: device.reportSize)
        
        device.sendFeatureReport(data: data)
    }
    
    /// Clears all keys by setting them to a black color
    ///
    /// See: `key(for:).clear()` to clear an individual key
    public func clearAllKeys() throws {
        try allKeys().forEach {
            try $0.clear()
        }
    }
    
    /// Returns the key at the given index throwing an error if out of bounds
    public func key(for index: Int) throws -> StreamDeckKey {
        let mapper = StreamDeckKeyMapper(product: product).userToDeviceMapping
        
        if mapper.isEmpty {
            try assertKeyInRange(index - 1)
            return StreamDeckKey(streamDeck: self, keyIndex: index - 1)
        }
        
        guard let mappedIndex = mapper[index] else {
            throw Error.keyIndexOutOfRange
        }
        
        try assertKeyInRange(mappedIndex)
        return StreamDeckKey(streamDeck: self, keyIndex: mappedIndex)
    }
    
    /// Returns all of the keys safely
    public func allKeys() -> [StreamDeckKey] {
        return keysRange().map({
            StreamDeckKey(streamDeck: self, keyIndex: $0)
        })
    }
    
    // Private
    
    /// Returns the range of the available keys on this device
    private func keysRange() -> Range<Int> {
        return 0 ..< product.keyCount
    }
    
    /// Validates that the key index is available on this device.
    ///
    /// Only throws an error if the key is not available
    private func assertKeyInRange(_ key: Int) throws {
        guard keysRange().contains(key) else {
            throw Error.keyIndexOutOfRange
        }
    }
    
    // Reading
    
    internal func receiveDataFromDevice(data: Data) {
        guard data.count >= product.dataCount else {
            Logger.error("Data received from device was not correct size (\(data.count) < \(product.dataCount))")
            return
        }
        
        // The first byte is the report ID
        // The last byte appears to be padding
        // We'll ignore these for now, the count should be equal to the key count.
        let keyData: Data
        
        switch product {
        case .streamDeck, .streamDeckMini:
            keyData = data[1 ... product.keyCount]
        case .streamDeckXL:
            // 1, 0, 32, ...
            keyData = data[4 ... 4 + product.keyCount]
        }
        
        for (keyIndex, keyValue) in keyData.enumerated() {
            keysPressed[keyIndex] = keyValue == 1
        }
        
        // End of functional logic, just printing out the pressed key to console
        
        let currentKeysPressed = keysPressed.filter({ $0.value })
            
        if currentKeysPressed.isEmpty {
            Logger.info("No Keys Pressed")
        } else {
            let keysPressedDescription = currentKeysPressed.map({ String($0.key) }).joined(separator: ", ")
            Logger.info("Keys Pressed: \(keysPressedDescription)")
        }
        
    }
    
    // Writing
    
    internal func write(data: Data) {
        device.write(data: data)
    }
    
    // Data Management
    
    internal func dataPageOne(keyIndex: Int, data: Data) -> Data {
        let bytes: [UInt8]
        
        switch product {
        case .streamDeck:
            bytes = [
                0x02, 0x01, 0x01, 0x00, 0x00, UInt8(keyIndex + 1),
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x42, 0x4d, 0xf6, 0x3c, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x36, 0x00, 0x00, 0x00,
                0x28, 0x00, 0x00, 0x00, 0x48, 0x00, 0x00, 0x00,
                0x48, 0x00, 0x00, 0x00, 0x01, 0x00, 0x18, 0x00,
                0x00, 0x00, 0x00, 0x00, 0xc0, 0x3c, 0x00, 0x00,
                0xc4, 0x0e, 0x00, 0x00, 0xc4, 0x0e, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            ]
            
        case .streamDeckMini:
            bytes = [
                0x02, 0x01, 0x00, 0x00, 0x00, UInt8(keyIndex + 1), 
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
                0x00, 0x00, 0x42, 0x4d, 0x36, 0x4b, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x36, 0x00, 0x00, 0x00,
                0x28, 0x00, 0x00, 0x00, 0x50, 0x00, 0x00, 0x00,
                0x50, 0x00, 0x00, 0x00, 0x01, 0x00, 0x18, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x4b, 0x00, 0x00,
                0x13, 0x0b, 0x00, 0x00, 0x13, 0x0b, 0x00, 0x00,
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            ]
            
        case .streamDeckXL:
            bytes = []
        }
        
        var pageOneData = Data(bytes)
        pageOneData.append(data)
        pageOneData.pad(toLength: product.pagePacketSize)
        
        return pageOneData
    }
    
    internal func dataPageTwo(keyIndex: Int, bufIndex: Int, data: Data, isLast: Bool = false) -> Data {
        let bytes: [UInt8]
        
        switch product {
        case .streamDeck:
            bytes = [
                0x02, 0x01, 0x02, 0x00, 0x01, UInt8(keyIndex + 1),
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            ]
            
        case .streamDeckMini:
            bytes = [
                0x02, 0x01, UInt8(bufIndex), 0x00, bufIndex == 0x13 ? 1 : 0, UInt8(keyIndex + 1), 
                0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
            ]
            
        case .streamDeckXL:
            let dataSize = UInt16(data.count).toBytes
            let bufIndexArr = UInt16(bufIndex).toBytes
            
            bytes = [
                0x02, 0x07, UInt8(keyIndex), isLast ? 1 : 0,
                dataSize[0], dataSize[1], bufIndexArr[0], bufIndexArr[1],
            ]
        }
        
        var pageTwoData = Data(bytes)
        pageTwoData.append(data)
        pageTwoData.pad(toLength: product.pagePacketSize)
        
        return pageTwoData
    }
    
}

protocol UIntToBytesConvertable {
    var toBytes: [UInt8] { get }
}

extension UIntToBytesConvertable {
    func toByteArr<T: BinaryInteger>(endian: T, count: Int) -> [UInt8] {
        var _endian = endian
        let bytePtr = withUnsafePointer(to: &_endian) {
            $0.withMemoryRebound(to: UInt8.self, capacity: count) {
                UnsafeBufferPointer(start: $0, count: count)
            }
        }
        return [UInt8](bytePtr)
    }
}

extension UInt16: UIntToBytesConvertable {
    var toBytes: [UInt8] {
        if CFByteOrderGetCurrent() == Int(CFByteOrderLittleEndian.rawValue) {
            return toByteArr(endian: self.littleEndian,
                         count: MemoryLayout<UInt16>.size)
        } else {
            return toByteArr(endian: self.bigEndian,
                             count: MemoryLayout<UInt16>.size)
        }
    }
}
