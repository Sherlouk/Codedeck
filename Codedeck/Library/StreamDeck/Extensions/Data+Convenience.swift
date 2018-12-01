//
//  Data+Convenience.swift
//  Codedeck
//
//  Created by Sherlock, James on 30/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

extension Data {
    
    // Pad Data to Length
    
    mutating func pad(toLength length: Int) {
        let padLength = length - count
        
        if padLength < 0 {
            Logger.error("Trying to pad data of length \(count) to \(length)")
            return
        } else if padLength == 0 {
            return
        }
        
        append(Data(repeating: 0x00, count: padLength))
    }
    
    // Repeat Data
    
    init(repeating values: [UInt8], count: Int) {
        let array = [[UInt8]].init(repeating: values, count: count).flatMap({ $0 })
        self.init(array)
    }
    
    func repeated(count: Int) -> Data {
        return Data.init(repeating: [UInt8](self), count: count)
    }
    
}
