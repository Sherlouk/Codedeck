//
//  Logger.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

public class Logger {
    
    public static var verboseMode = true
    
    private enum Severity: String {
        case error = "Error"
        case warning = "Warning"
        case info = "Info"
        case success = "Sucess"
        
        var emojiPrefix: String {
            switch self {
            case .error: return "❤️"
            case .warning: return "💛"
            case .info: return "💙"
            case .success: return "💚"
            }
        }
        
        var isVerbose: Bool {
            switch self {
            case .error, .warning: return false
            case .info, .success: return true
            }
        }
    }
    
    // Private
    
    private class func log(_ message: String, severity: Severity) {
        if severity.isVerbose && !Logger.verboseMode {
            return
        }
        
        print("[\(severity.emojiPrefix) \(severity.rawValue)] \(message)")
    }
    
    // Convenience
    
    internal class func error(_ message: String) {
        log(message, severity: .error)
    }
    
    internal class func warning(_ message: String) {
        log(message, severity: .warning)
    }
    
    internal class func info(_ message: String) {
        log(message, severity: .info)
    }
    
    internal class func success(_ message: String) {
        log(message, severity: .success)
    }
    
}
