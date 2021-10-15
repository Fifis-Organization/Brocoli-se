//
//  BrocoliSeTests.swift
//  BrocoliSeTests
//
//  Created by Nathalia Cardoso on 01/10/21.
//

import XCTest
import CoreData
@testable import BrocoliSe

class DiaryViewControllerTests: XCTestCase {
    
    func test_fetchDayAll_should_complete_with_days_if_there_is_data_in_coreData() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        let calendar = Calendar(identifier: .gregorian)
        let yesterday: Day = coreData.createEntity()
        yesterday.date = calendar.date(byAdding: .day, value: -1, to: Date())
        
        coreData.save()
        
        XCTAssertNotNil(scene.daySelected)
        
        controller.fetchDayAll()
        XCTAssertNotNil(scene.days)
        XCTAssertEqual(scene.days?.last, yesterday)
        removeDatas(coreDataManagerMock: coreData)
    }
    
    func test_fetchFoodAll_should_complete_with_foods_if_there_is_data_in_coreData() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        let food: FoodOff = coreData.createEntity()
        food.food = "Brocolis"
        
        coreData.save()
        
        controller.fetchFoodAll()
        XCTAssertNotNil(scene.foods)
        XCTAssertEqual(scene.foods?.last, food)
        removeDatas(coreDataManagerMock: coreData)
    }
    
    func test_fetchUser_should_complete_with_the_user_if_there_is_data_in_coreData() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        let user: User = coreData.createEntity()
        user.name = "Gostosão do telegram"
        user.point = 30
        
        coreData.save()
        
        controller.fetchUser()
        XCTAssertNotNil(scene.user)
        XCTAssertEqual(scene.user, user)
        removeDatas(coreDataManagerMock: coreData)
    }
    
    func test_fetchDay_should_complete_with_the_user_if_there_is_data_in_coreData() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        let calendar = Calendar(identifier: .gregorian)
        let date = calendar.date(byAdding: .day, value: -2, to: Date()) ?? Date()
        
        let today: Day = coreData.createEntity()
        today.date = date
        
        coreData.save()
        
        let daySelected = calendar.component(.day, from: date)
        let monthSelected = calendar.component(.month, from: date)
        let yearSelected = calendar.component(.year, from: date)
        
        controller.fetchDay(date)
        
        let dateReceived = scene.daySelected?.date ?? Date()
        let dayReceived = calendar.component(.day, from: dateReceived)
        let monthReceived = calendar.component(.month, from: dateReceived)
        let yearReceived = calendar.component(.year, from: dateReceived)
        
        XCTAssertEqual(daySelected, dayReceived)
        XCTAssertEqual(monthSelected, monthReceived)
        XCTAssertEqual(yearSelected, yearReceived)
        
        let dateNotExist = calendar.date(byAdding: .day, value: -3, to: Date()) ?? Date()
        controller.fetchDay(dateNotExist)
        
        XCTAssertNil(scene.daySelected?.date)
        
        removeDatas(coreDataManagerMock: coreData)
    }
    
    func test_saveFood() {
        let (controller, coreData, scene) = makeSetupInitial()
        
        let today: Day = coreData.createEntity()
        today.date = Date()
        let food1: FoodOff = coreData.createEntity()
        food1.food = "Brocolis"
        let food2: FoodOff = coreData.createEntity()
        food2.food = "Frutas"
        
        controller.saveFood(ingestedFood: [food1], noIngestedFood: [food2], today: today)
        controller.fetchDay(Date())
        let dayReceive: Day? = scene.daySelected
        
        XCTAssertEqual(dayReceive?.ingested, [food1])
        XCTAssertEqual(dayReceive?.noIngested, [food2])
    }
    
    func test_createToday() {
        let (controller, _, _) = makeSetupInitial()
        let today = controller.createToday()
        
        let calendar = Calendar(identifier: .gregorian)
        let daySelected = calendar.component(.day, from: Date())
        let monthSelected = calendar.component(.month, from: Date())
        let yearSelected = calendar.component(.year, from: Date())
        
        guard let dateReceived = today?.date else {
            XCTFail("No expected nil")
            return
        }
        let dayReceived = calendar.component(.day, from: dateReceived)
        let monthReceived = calendar.component(.month, from: dateReceived)
        let yearReceived = calendar.component(.year, from: dateReceived)
        
        XCTAssertEqual(daySelected, dayReceived)
        XCTAssertEqual(monthSelected, monthReceived)
        XCTAssertEqual(yearSelected, yearReceived)
    }
}

extension DiaryViewControllerTests {
    func makeSetupInitial() -> (DiaryViewController, CoreDataManagerMock, DiarySceneMock) {
        let controller: DiaryViewController = DiaryViewController()
        let coreDataManagerMock: CoreDataManagerMock = CoreDataManagerMock()
        let diarySceneMock: DiarySceneMock = DiarySceneMock()
        
        controller.setCoreDataManager(coreDataManagerMock)
        controller.setDiaryScene(diarySceneMock)
        controller.loadViewIfNeeded()
        
        return (controller, coreDataManagerMock, diarySceneMock)
    }
    
    func removeDatas(coreDataManagerMock: CoreDataManagerMock) {
        let requestUser = NSFetchRequest<NSFetchRequestResult>(entityName: User.entityName)
        coreDataManagerMock.removeEntity(request: requestUser)
        
        let requestDay = NSFetchRequest<NSFetchRequestResult>(entityName: Day.entityName)
        coreDataManagerMock.removeEntity(request: requestDay)
        
        let requestFoodOff = NSFetchRequest<NSFetchRequestResult>(entityName: FoodOff.entityName)
        coreDataManagerMock.removeEntity(request: requestFoodOff)
        
        coreDataManagerMock.save()
    }
}
