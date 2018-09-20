//
//  MGHomeViewController.swift
//  MemoryGame
//
//  Created by  Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import UIKit

class MGHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let startNewGameButton = UIButton(type: .system)
        view.addSubview(startNewGameButton)
        
        startNewGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startNewGameButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        startNewGameButton.setTitle("Start New Game", for: .normal)
        startNewGameButton.sizeToFit()
        startNewGameButton.translatesAutoresizingMaskIntoConstraints = false
        startNewGameButton.addTarget(self, action: #selector(startNewGame), for: .touchUpInside)
        
        view.backgroundColor = UIColor.white
    }
    
    @objc private func startNewGame() {
        print("start new game")
    }
}

