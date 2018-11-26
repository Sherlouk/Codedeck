//
//  IOHIDDevice+GetProperty.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation
import IOKit.hid

extension IOHIDDevice {
    
    enum Error: Swift.Error {
        case failedToFindProperty
        case mismatchPropertyType(expected: String, actual: String) // TODO: Expected/Actual types
    }
    
    func getProperty<T>(key: String) throws -> T {
        
        guard let value = IOHIDDeviceGetProperty(self, key as CFString) else {
            throw Error.failedToFindProperty
        }
        
        guard let typedValue = value as? T else {
            throw Error.mismatchPropertyType(expected: String(describing: T.self), actual: "\(type(of: value))")
        }
        
        return typedValue
        
    }
    
}
