//
//  MGHomeViewController.swift
//  MemoryGame
//
//  Created by  Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import UIKit

class MGHomeViewController: UIViewController, MGGameTypeButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.text = "Memory Game!"
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let startEasyGameButton = MGGameTypeButton(.easy)
        startEasyGameButton.delegate = self
        view.addSubview(startEasyGameButton)
        startEasyGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startEasyGameButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0).isActive = true
        
        let startMediumGameButton = MGGameTypeButton(.medium)
        startMediumGameButton.delegate = self
        view.addSubview(startMediumGameButton)
        startMediumGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startMediumGameButton.topAnchor.constraint(equalTo: startEasyGameButton.bottomAnchor, constant: 20.0).isActive = true
        
        let startHardGameButton = MGGameTypeButton(.hard)
        startHardGameButton.delegate = self
        view.addSubview(startHardGameButton)
        startHardGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startHardGameButton.topAnchor.constraint(equalTo: startMediumGameButton.bottomAnchor, constant: 20.0).isActive = true
        
        // TODO: Add Profile button to show past game scores
        
        view.backgroundColor = UIColor.white
    }
    
    func didTapGameTypeButton(_ gameType: MGGameType) {
        present(MGGameViewController(gameType: gameType), animated: true, completion: nil)
    }
}

