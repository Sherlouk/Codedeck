//
//  IOHIDDevice+Write.swift
//  Codedeck
//
//  Created by Sherlock, James on 30/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

extension IOHIDDevice {
    
    public func write(data: Data) {
        // TODO https://github.com/Arti3DPlayer/USBDeviceSwift/blob/master/RaceflightControllerHIDExample/RaceflightControllerHIDExample/RFDevice.swift#L26
        
        print(data.count)
    }
    
}
