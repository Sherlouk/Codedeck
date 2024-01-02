//
//  Data+JPEG.swift
//  Codedeck
//
//  Created by Sherlock, James on 30/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import Cocoa

extension Data {
    func processJPEG(width: Int) -> [UInt8]? {
        let bytes = Array(self)
        let bytesPerRow = width * 4
        
        guard let rgbaData = CFDataCreate(nil, bytes, bytes.count) else {
            return nil
        }
        
        guard let provider = CGDataProvider(data: rgbaData) else {
            return nil
        }
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.noneSkipLast.rawValue)
        
        guard let cgImage = CGImage(
            width: bytesPerRow / 4,
            height: bytes.count / bytesPerRow,
            bitsPerComponent: 8,
            bitsPerPixel: 32,
            bytesPerRow: bytesPerRow,
            space: colorSpace,
            bitmapInfo: bitmapInfo,
            provider: provider,
            decode: nil,
            shouldInterpolate: true,
            intent: .defaultIntent
        ) else {
            return nil
        }
        
        let bitmap = NSBitmapImageRep(cgImage: cgImage)
        
        guard let data = bitmap.representation(using: .jpeg, properties: [.compressionFactor: 0.75]) else {
            return nil
        }
        
        return Array(data)
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}
