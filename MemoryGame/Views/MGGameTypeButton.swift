//
//  MGGameTypeButton.swift
//  MemoryGame
//
//  Created by Matthew Buckle on 9/20/18.
//  Copyright © 2018 interview. All rights reserved.
//

import UIKit

class MGGameTypeGestureRecognizer: UITapGestureRecognizer {
    var gameType: MGGameType?
}

protocol MGGameTypeButtonDelegate: class {
    func didTapGameTypeButton(_ gameType: MGGameType)
}

class MGGameTypeButton: UIButton {
    
    let gameType: MGGameType
    
    weak var delegate: MGGameTypeButtonDelegate?
    
    required init(_ buttonGameType: MGGameType) {
        gameType = buttonGameType
        
        super.init(frame: .zero)
        
        switch gameType {
        case .easy:
            setTitle("Easy", for: .normal)
            break
        case .medium:
            setTitle("Medium", for: .normal)
            break
        case .hard:
            setTitle("Hard", for: .normal)
            break
        }
        setTitleColor(.blue, for: .normal)
        
        sizeToFit()
        translatesAutoresizingMaskIntoConstraints = false
        
        let gestureRecognizer = MGGameTypeGestureRecognizer(target: self, action: #selector(startGame(gestureRecognizer:)))
        gestureRecognizer.gameType = gameType
        addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func startGame(gestureRecognizer: MGGameTypeGestureRecognizer) {
        delegate?.didTapGameTypeButton(gestureRecognizer.gameType ?? .easy)
    }
}
