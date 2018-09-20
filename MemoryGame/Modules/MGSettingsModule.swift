//
//  MGSettingsModule.swift
//  MemoryGame
//
//  Created by  Matthew Buckle on 9/19/18.
//  Copyright © 2018 interview. All rights reserved.
//

import Foundation

enum MGCacheKey: String {
    case lastGameId = "lastGameId"
    case lastGameState = "lastGameState"
    case lastGameScore = "lastGameScore"
    case lastGameCards = "lastGameCards"
    case lastGameType = "lastGameType"
    case numberOfMatches = "numberOfMatches"
}

class MGSettingsModule: NSObject {
    
    private let userDefaults: UserDefaults
    private let absoluteNamespace: String
    
    init(from userDefaults: UserDefaults = UserDefaults.standard, prefix: String = "MG", with userIdentifier: String = "", for namespace: String = "") {
        self.userDefaults = userDefaults
        
        // NOTE: Cache key format: <project prefix>|<user id>|<namespace>|<setting key>
        self.absoluteNamespace = "\(prefix)|\(userIdentifier)|\(namespace)"
    }
    
    private func namespaceKey(_ settingKey: String) -> String {
        return "\(self.absoluteNamespace)|\(settingKey)"
    }
    
    public func hasKey(_ settingKey: String) -> Bool {
        return self.userDefaults.object(forKey: self.namespaceKey(settingKey)) != nil
    }
    
    public func object(for settingKey: String) -> Any? {
        return self.userDefaults.object(forKey: self.namespaceKey(settingKey))
    }
    
    public func setObject(value: Any?, for settingKey: String) {
        self.userDefaults.set(value, forKey: self.namespaceKey(settingKey))
    }
    
    public func lastGameId() -> Int {
        return self.object(for: MGCacheKey.lastGameId.rawValue) as? Int ?? 0
    }
    
    public func storeLastGameCards(_ cards: [MGCard]) {
        let encoded = NSKeyedArchiver.archivedData(withRootObject: cards)
        self.userDefaults.set(encoded, forKey: MGCacheKey.lastGameCards.rawValue)
    }
    
    public func lastGameCards() -> [MGCard] {
        let decoded = self.userDefaults.object(forKey: MGCacheKey.lastGameCards.rawValue) as? Data ?? Data()
        return NSKeyedUnarchiver.unarchiveObject(with: decoded) as? [MGCard] ?? [MGCard]()
    }
}
