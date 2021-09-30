//
//  PersistenceService.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 22/09/21.
//

import Foundation

class PersistenceService {
    
    private let defaults: UserDefaults
    
    private enum Keys: String {
        case firstLoad
    }
    
    init(defaults: UserDefaults = UserDefaults()) {
        self.defaults = defaults
    }
    
    func persist(firstLoad: Bool) {
        defaults.set(firstLoad, forKey: Keys.firstLoad.rawValue)
    }
    
    func getFirstLoad() -> Bool {
        return defaults.bool(forKey: Keys.firstLoad.rawValue)
    }
}
