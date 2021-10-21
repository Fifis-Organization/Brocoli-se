//
//  DiarySceneMock.swift
//  BrocoliSeTests
//
//  Created by Samuel Sales on 07/10/21.
//

import Foundation
import CoreData
@testable import BrocoliSe

class DiarySceneMock: DiarySceneDelegate {
    var days: [Day]?
    var foods: [FoodOff]?
    var controller: DiaryViewController?
    var daySelected: Day?
    var user: User?
    var textLabel: String?
    var isPresent = false
    
    func setDayAll(days: [Day]) {
        self.days = days
    }
    
    func setFoodAll(foods: [FoodOff]) {
        self.foods = foods
    }
    
    func setController(controller: DiaryViewController) {
        self.controller = controller
    }
    
    func setUser(user: User?) {
        self.user = user
    }
    
    func setDay(daySelected: Day?) {
        self.daySelected = daySelected
    }
    
    func presenterModal(_ modal: ModalViewController) {
        isPresent = true
    }
    
    func setupDatas() {
        controller?.fetchUser()
        controller?.fetchDayAll()
        controller?.fetchFoodAll()
    }
    
    func setTextLabelProgress(_ text: String) {
        textLabel = text
    }
}
