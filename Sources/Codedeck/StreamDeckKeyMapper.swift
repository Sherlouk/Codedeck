//
//  StreamDeckKeyMapper.swift
//  Codedeck
//
//  Created by Sherlock, James on 02/12/2018.
//

import Foundation

internal struct StreamDeckKeyMapper {
    
    internal var userToDeviceMapping: [Int: Int] = [
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
    
    internal var deviceToUserMapping: [Int: Int] = [
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
    
}
