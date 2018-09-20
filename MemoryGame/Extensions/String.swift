//
//  String.swift
//  MemoryGame
//
//  Created by Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import Foundation

extension String {
    static func randomEmoji() -> String {
        let range = [UInt32](0x1F601...0x1F64F)
        let ascii = range[Int(drand48() * (Double(range.count)))]
        
        return UnicodeScalar(ascii)?.description ?? ""
    }
}
