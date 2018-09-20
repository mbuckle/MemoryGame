//
//  MGCard.swift
//  MemoryGame
//
//  Created by  Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import Foundation

class MGCard: NSObject, NSCoding {
    let iconName: String
    var isMatched: Bool
    
    init(iconName: String, isMatched: Bool) {
        self.iconName = iconName
        self.isMatched = isMatched
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let iconName = aDecoder.decodeObject(forKey: "iconName") as? String ?? ""
        let isMatched = aDecoder.decodeBool(forKey: "isMatched")
        self.init(iconName: iconName, isMatched: isMatched)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(iconName, forKey: "iconName")
        aCoder.encode(isMatched, forKey: "isMatched")
    }
}
