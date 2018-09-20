//
//  MGGame.swift
//  MemoryGame
//
//  Created by  Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import Foundation

enum MGGameType {
    case easy
    case medium
    case hard
}

enum MGGameState {
    case notStarted
    case inProgress
    case completed
}

struct MGGame {
    let gameId: String
    let gameType: MGGameType
    var gameState: MGGameState
    var score: Int
}
