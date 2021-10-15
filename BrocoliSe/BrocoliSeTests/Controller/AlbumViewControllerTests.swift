//
//  AlbumViewControllerTests.swift
//  BrocoliSeTests
//
//  Created by Samuel Sales on 07/10/21.
//

import Foundation
import CoreData
@testable import BrocoliSe
import XCTest
// swiftlint:disable large_tupla

class AlbumViewControllerTests: XCTestCase {
    
    func test_fetchUser_should_complete_with_the_user_if_there_is_data_in_coreData() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        XCTAssertNotNil(scene.controller)
        
        let user: User = coreData.createEntity()
        user.name = "Gostosão do telegram"
        user.point = 30
        
        coreData.save()
        
        XCTAssertNil(scene.user)
        controller.fetchUser()
        XCTAssertEqual(scene.user, user)
        removeDatas(coreDataManagerMock: coreData)
    }
    
    func test_reload_should_triggered_when_called() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        XCTAssertFalse(scene.reload)
        controller.reload()
        XCTAssertTrue(scene.reload)
        
        removeDatas(coreDataManagerMock: coreData)
    }

}

extension AlbumViewControllerTests {
    func makeSetupInitial() -> (AlbumViewController, CoreDataManagerMock, AlbumSceneMock) {
        let controller: AlbumViewController = AlbumViewController()
        let coreDataManagerMock: CoreDataManagerMock = CoreDataManagerMock()
        let albumSceneMock: AlbumSceneMock = AlbumSceneMock()
        
        controller.setCoreDataManager(coreDataManagerMock)
        controller.setAlbumScene(albumSceneMock)
        controller.loadViewIfNeeded()
        
        return (controller, coreDataManagerMock, albumSceneMock)
    }
    
    func removeDatas(coreDataManagerMock: CoreDataManagerMock) {
        let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: User.entityName)
        coreDataManagerMock.removeEntity(request: requestUser)
        coreDataManagerMock.save()
    }
}
