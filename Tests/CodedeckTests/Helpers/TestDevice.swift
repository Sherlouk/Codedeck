//
//  TestDevice.swift
//  CodedeckTests
//
//  Created by Sherlock, James on 01/12/2018.
//

import Foundation
@testable import HIDSwift

class TestDevice: ReadDevice, WriteDevice, FeatureReportDevice {
    
    var writeBlock: ((Data) -> ())?
    
    func registerInputReportCallback(reportSize: Int, callback: @escaping IOHIDReportCallback, context: UnsafeMutableRawPointer?) {
        
    }
    
    func getFeatureReport(reportSize: Int) {
        
    }
    
    func sendFeatureReport(data: Data) {
        
    }
    
    func write(data: Data) {
        writeBlock?(data)
    }
    
}
