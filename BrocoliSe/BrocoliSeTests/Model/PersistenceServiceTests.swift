//
//  CoredataManagerTest.swift
//  BrocoliSeTests
//
//  Created by Samuel Sales on 14/10/21.
//

import XCTest
import CoreData
@testable import BrocoliSe

class PersistenceServiceTests: XCTestCase {
    
    func test_persistenceService() {
        let persistenceService = PersistenceService(defaults: UserDefaults())
        let valueInitial: Bool = persistenceService.getKeyValue(udKey: UserDefaultsKeys.firstLoad) ? true : false
    
        persistenceService.persist(udKey: UserDefaultsKeys.firstLoad, value: true)
        XCTAssertTrue(persistenceService.getKeyValue(udKey: UserDefaultsKeys.firstLoad))
        
        persistenceService.persist(udKey: UserDefaultsKeys.firstLoad, value: false)
        XCTAssertFalse(persistenceService.getKeyValue(udKey: UserDefaultsKeys.firstLoad))
        
        persistenceService.persist(udKey: UserDefaultsKeys.firstLoad, value: valueInitial)
    }
    
}
