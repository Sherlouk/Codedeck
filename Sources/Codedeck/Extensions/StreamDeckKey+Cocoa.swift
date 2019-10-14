//
//  StreamDeckKey+Cocoa.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

#if canImport(Cocoa)

import Foundation
import Cocoa

public extension StreamDeckKey {
    
    func setColor(color: NSColor) throws {
        try setColor(
            red: Int(color.redComponent * 255),
            green: Int(color.greenComponent * 255),
            blue: Int(color.blueComponent * 255)
        )
    }
    
}

#endif
