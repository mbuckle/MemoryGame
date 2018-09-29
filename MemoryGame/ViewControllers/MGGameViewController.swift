//
//  MGGameViewController.swift
//  MemoryGame
//
//  Created by Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import UIKit

class MGGameViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var game: MGGame
    var cards: [MGCard]
    var lastPickCell: MGCardViewCell?
    var lastPickIndexPath: IndexPath?
    var numberOfMatches: Int = 0
    var showingPreviousPicks: Bool = false
    
    let playAgainButton = UIButton(type: .system)
    let returnHomeButton = UIButton(type: .system)
    let scoreLabel = UILabel()
    
    init(gameType: MGGameType) {
        let lastGame = MGSettingsModule.sharedInstance.object(for: MGCacheKey.lastGame.rawValue) as? MGGame
        let gameId = (lastGame?.gameId ?? 0) + 1
        
        game = MGGame(gameId: gameId, gameType: gameType)
        MGSettingsModule.sharedInstance.setObject(value: game, for: MGCacheKey.lastGame.rawValue)
        
        cards = game.randomCards()
        MGSettingsModule.sharedInstance.setObject(value: cards, for: MGCacheKey.lastGameCards.rawValue)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    init(currentGame: MGGame) {
        game = currentGame
        cards = MGSettingsModule.sharedInstance.object(for: MGCacheKey.lastGameCards.rawValue) as? [MGCard] ?? currentGame.randomCards()
        numberOfMatches = MGSettingsModule.sharedInstance.object(for: MGCacheKey.numberOfMatches.rawValue) as? Int ?? 0
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameLayout = UICollectionViewFlowLayout()
        gameLayout.sectionInset = UIEdgeInsets(top: 100.0, left: 10.0, bottom: 10.0, right: 10.0)
        gameLayout.itemSize = CGSize(width: 50.0, height: 50.0)
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: gameLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MGCardViewCell.self, forCellWithReuseIdentifier: "MyCardViewCell")
        collectionView.backgroundColor = UIColor.clear
        view.addSubview(collectionView)
        
        view.addSubview(returnHomeButton)
        returnHomeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        returnHomeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50.0).isActive = true
        returnHomeButton.setTitle("Return to Home Screen", for: .normal)
        returnHomeButton.sizeToFit()
        returnHomeButton.translatesAutoresizingMaskIntoConstraints = false
        returnHomeButton.addTarget(self, action: #selector(returnHome), for: .touchUpInside)
        returnHomeButton.isHidden = true
        
        view.addSubview(playAgainButton)
        playAgainButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playAgainButton.bottomAnchor.constraint(equalTo: returnHomeButton.topAnchor, constant: -20.0).isActive = true
        playAgainButton.setTitle("Play Again!", for: .normal)
        playAgainButton.sizeToFit()
        playAgainButton.translatesAutoresizingMaskIntoConstraints = false
        playAgainButton.addTarget(self, action: #selector(playAgain), for: .touchUpInside)
        playAgainButton.isHidden = true
        
        view.addSubview(scoreLabel)
        scoreLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        scoreLabel.bottomAnchor.constraint(equalTo: playAgainButton.topAnchor, constant: -20.0).isActive = true
        scoreLabel.text = "Score: \(game.score)"
        scoreLabel.sizeToFit()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = UIColor.white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCardViewCell", for: indexPath) as? MGCardViewCell else {
            return UICollectionViewCell()
        }
        
        cell.label.text = cards[indexPath.row].iconName
        
        if cards[indexPath.row].isMatched {
            cell.label.isHidden = false
            cell.backgroundColor = UIColor.green
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MGCardViewCell, cards[indexPath.row].isMatched == false, indexPath != lastPickIndexPath, showingPreviousPicks == false else {
            return
        }
        
        game.gameState = .inProgress
        cell.label.isHidden = !cell.label.isHidden
        
        if lastPickIndexPath == nil {
            lastPickIndexPath = indexPath
            lastPickCell = cell
        } else {
            if let lastIndexPath = lastPickIndexPath, cards[lastIndexPath.row].iconName == cards[indexPath.row].iconName, let lastCell = lastPickCell {
                lastCell.backgroundColor = UIColor.green
                cards[lastIndexPath.row].isMatched = true
                
                cell.backgroundColor = UIColor.green
                cards[indexPath.row].isMatched = true
                MGSettingsModule.sharedInstance.setObject(value: cards, for: MGCacheKey.lastGameCards.rawValue)
                
                numberOfMatches += 1
                MGSettingsModule.sharedInstance.setObject(value: numberOfMatches, for: MGCacheKey.numberOfMatches.rawValue)
            } else {
                showingPreviousPicks = true
                let lastCell = lastPickCell
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(1)) {
                    lastCell?.label.isHidden = true
                    cell.label.isHidden = true
                    self.showingPreviousPicks = false
                }
            }
            
            lastPickCell = nil
            lastPickIndexPath = nil
            
            game.score += 1
            scoreLabel.text = "Score: \(game.score)"
            
            if numberOfMatches == game.numberOfMatches {
                game.gameState = .completed
                
                // TODO: persist game score in game history for profile
                playAgainButton.isHidden = false
                returnHomeButton.isHidden = false
            }
        }
        
        MGSettingsModule.sharedInstance.setObject(value: game, for: MGCacheKey.lastGame.rawValue)
    }
    
    @objc func playAgain() {
        present(MGGameViewController(gameType: game.gameType), animated: true, completion: nil)
    }
    
    @objc func returnHome() {
        present(MGHomeViewController(), animated: true, completion: nil)
    }
}

