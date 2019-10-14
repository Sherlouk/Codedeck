//
//  StreamDeckKeyMapper.swift
//  Codedeck
//
//  Created by Sherlock, James on 02/12/2018.
//

import Foundation

internal struct StreamDeckKeyMapper {
    
    let product: StreamDeckProduct
    
    internal var userToDeviceMapping: [Int: Int] {
        switch product {
        case .streamDeck:
            return [
                1: 4,
                2: 3,
                3: 2,
                4: 1,
                5: 0,
                6: 9,
                7: 8,
                8: 7,
                9: 6,
                10: 5,
                11: 14,
                12: 13,
                13: 12,
                14: 11,
                15: 10,
            ]
        case .streamDeckMini:
            return [
                1: 0,
                2: 1,
                3: 2,
                4: 3,
                5: 4,
                6: 5,
            ]
        }
    }
    
    internal var deviceToUserMapping: [Int: Int] {
        switch product {
        case .streamDeck:
            return [
                0: 5,
                1: 4,
                2: 3,
                3: 2,
                4: 1,
                5: 10,
                6: 9,
                7: 8,
                8: 7,
                9: 6,
                10: 15,
                11: 14,
                12: 13,
                13: 12,
                14: 11
            ]
        case .streamDeckMini:
            return [
                0: 1,
                1: 2,
                2: 3,
                3: 4,
                4: 5,
                5: 6
            ]
        }
    }
    
    
}
