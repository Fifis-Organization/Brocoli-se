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
        let persistenceService = PersistenceService()
        persistenceService.persist(firstLoad: true)
        XCTAssertTrue(persistenceService.getFirstLoad())
        
        persistenceService.persist(firstLoad: false)
        XCTAssertFalse(persistenceService.getFirstLoad())
    }
    
}

