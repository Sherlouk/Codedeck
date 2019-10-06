//
//  HIDDevice+StreamDeckProduct.swift
//  Codedeck
//
//  Created by Sherlock, James on 26/11/2018.
//  Copyright © 2018 Sherlouk. All rights reserved.
//

import Foundation

#if canImport(HIDSwift)
import HIDSwift
#endif

public extension HIDDevice {
    
    enum Error: Swift.Error, LocalizedError {
        // notStreamDeckProduct: - HIDDevice is not a known StreamDeck product
        case notStreamDeckProduct
        
        public var localizedDescription: String {
            switch self {
            case .notStreamDeckProduct: return "Not a StreamDeck Product"
            }
        }
    }
    
    func makeStreamDeckProduct() throws -> StreamDeckProduct {
        let product = StreamDeckProduct.allCases.first(where: {
            $0.vendorId == self.vendorId && $0.productId == self.productId
        })
        
        guard let unwrappedProduct = product else {
            throw Error.notStreamDeckProduct
        }
        
        return unwrappedProduct
    }
    
}
