//
//  MGApiClient.swift
//  MemoryGame
//
//  Created by Matthew Buckle on 9/20/18.
//  Copyright © 2018 interview. All rights reserved.
//

import Foundation

class MGApiClient {
    
    lazy var baseUrl: URL? = {
        return URL(string: "https://my.api.com")
    }()
    
    let decoder = JSONDecoder()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias LastGameCompletionHandler = (MGGame?, Error?) -> Void
    
    func getLastGame(completionHandler completion: @escaping LastGameCompletionHandler) {
        
        // Mock data
        guard let gameTypeInt = MGSettingsModule().object(for: MGCacheKey.lastGameType.rawValue) as? MGGameType.RawValue, let gameType = MGGameType(rawValue: gameTypeInt), let gameStateInt = MGSettingsModule().object(for: MGCacheKey.lastGameState.rawValue) as? MGGameState.RawValue, let gameState = MGGameState(rawValue: gameStateInt), let score = MGSettingsModule().object(for: MGCacheKey.lastGameScore.rawValue) as? Int else {
            completion(nil, MGError.invalidData)
            return
        }
        
        completion(MGGame(gameId: MGSettingsModule().lastGameId(),
                          gameType: gameType,
                          gameState: gameState,
                          score: score), nil)
        
        /*
        guard let url = URL(string: "", relativeTo: baseUrl) else {
            completion(nil, MGError.invalidUrl)
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = session.dataTask(with: request) {data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, MGError.requestFailed)
                        return
                    }
                    if httpResponse.statusCode == 200 {
                        do {
                            let game = try self.decoder.decode(MGGame.self, from: data)
                            completion(game, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, MGError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        
        task.resume()
    */
    }
}
