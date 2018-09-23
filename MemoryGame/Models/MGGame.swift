//
//  MGGame.swift
//  MemoryGame
//
//  Created by  Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import Foundation

@objc enum MGGameType: Int, Codable {
    case easy
    case medium
    case hard
}

enum MGGameState: Int, Codable {
    case notStarted
    case inProgress
    case completed
}

class MGGame: NSObject, Codable, NSCoding {
    let gameId: Int
    let gameType: MGGameType
    var gameState: MGGameState
    var score: Int
    
    init(gameId: Int, gameType: MGGameType, gameState: MGGameState = .notStarted, score: Int = 0) {
        self.gameId = gameId
        self.gameType = gameType
        self.gameState = gameState
        self.score = score
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(gameId, forKey: "gameId")
        aCoder.encode(gameType.rawValue, forKey: "gameType")
        aCoder.encode(gameState.rawValue, forKey: "gameState")
        aCoder.encode(score, forKey: "score")
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let gameId = aDecoder.decodeInteger(forKey: "gameId")
        let gameTypeInt = aDecoder.decodeInteger(forKey: "gameType")
        let gameType = MGGameType(rawValue: gameTypeInt) ?? .easy
        let gameStateInt = aDecoder.decodeInteger(forKey: "gameState")
        let gameState = MGGameState(rawValue: gameStateInt) ?? .notStarted
        let score = aDecoder.decodeInteger(forKey: "score")
        self.init(gameId: gameId, gameType: gameType, gameState: gameState, score: score)
    }
}

extension MGGame {
    var numberOfMatches: Int {
        switch gameType {
        case .easy:
            return 3
        case .medium:
            return 6
        case .hard:
            return 12
        }
    }
}

extension MGGame {
    var cards: [MGCard] {
        return randomCards()
    }
    
    private func randomCards() -> [MGCard] {
        var newCards = [MGCard]()
        for _ in 1...numberOfMatches {
            var card: MGCard
            repeat {
                card = MGCard(iconName: String.randomEmoji(), isMatched: false)
            } while (newCards.contains(card) || card.iconName.isEmpty)
            
            newCards.append(card)
            newCards.append(card)
        }
        newCards.shuffle()
        return newCards
    }
}
