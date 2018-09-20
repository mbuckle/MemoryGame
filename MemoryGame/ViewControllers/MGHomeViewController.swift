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
        
        let titleLabel = UILabel()
        view.addSubview(titleLabel)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.text = "Memory Game!"
        titleLabel.sizeToFit()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let startEasyGameButton = UIButton(type: .system)
        view.addSubview(startEasyGameButton)
        
        startEasyGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startEasyGameButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20.0).isActive = true
        startEasyGameButton.setTitle("Easy Game", for: .normal)
        startEasyGameButton.sizeToFit()
        startEasyGameButton.translatesAutoresizingMaskIntoConstraints = false
        startEasyGameButton.addTarget(self, action: #selector(startEasyGame), for: .touchUpInside)
        
        let startMediumGameButton = UIButton(type: .system)
        view.addSubview(startMediumGameButton)
        
        startMediumGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startMediumGameButton.topAnchor.constraint(equalTo: startEasyGameButton.bottomAnchor, constant: 20.0).isActive = true
        startMediumGameButton.setTitle("Medium Game", for: .normal)
        startMediumGameButton.sizeToFit()
        startMediumGameButton.translatesAutoresizingMaskIntoConstraints = false
        startMediumGameButton.addTarget(self, action: #selector(startMediumGame), for: .touchUpInside)
        
        let startHardGameButton = UIButton(type: .system)
        view.addSubview(startHardGameButton)
        
        startHardGameButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startHardGameButton.topAnchor.constraint(equalTo: startMediumGameButton.bottomAnchor, constant: 20.0).isActive = true
        startHardGameButton.setTitle("Hard Game", for: .normal)
        startHardGameButton.sizeToFit()
        startHardGameButton.translatesAutoresizingMaskIntoConstraints = false
        startHardGameButton.addTarget(self, action: #selector(startHardGame), for: .touchUpInside)
        
        // TODO: Optimize and remove redundant code
        // TODO: Add Profile button to show past game scores
        
        view.backgroundColor = UIColor.white
    }
    
    @objc private func startEasyGame() {
        present(MGGameViewController(gameType: .easy), animated: true, completion: nil)
    }
    
    @objc private func startMediumGame() {
        present(MGGameViewController(gameType: .medium), animated: true, completion: nil)
    }
    
    @objc private func startHardGame() {
        present(MGGameViewController(gameType: .hard), animated: true, completion: nil)
    }
}

