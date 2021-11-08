//
//  PersistenceService.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 22/09/21.
//

import Foundation

enum UserDefaultsKeys: String {
    case firstLoad
    case vibrations
    case notifications
    case firstLaunch
}

class PersistenceService {
    
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = UserDefaults()) {
        self.defaults = defaults
    }
    
    func persist(udKey: UserDefaultsKeys, value: Bool) {
        defaults.set(value, forKey: udKey.rawValue)
    }
    
    func getKeyValue(udKey: UserDefaultsKeys) -> Bool {
        return defaults.bool(forKey: udKey.rawValue)
    }
}
