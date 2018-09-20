//
//  MGCardViewCell.swift
//  MemoryGame
//
//  Created by Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import UIKit

class MGCardViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
