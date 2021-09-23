//
//  ViewController.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

protocol DiarySceneDelegate: AnyObject {
    func setDayAll(days: [Day])
    func setFoodAll(foods: [FoodOff])
    func setController(controller: DiaryViewController)
    func setUser(user: User?)
    func setupDatas()
}

class DiaryViewController: UIViewController {
    private var diaryScene: DiarySceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    func setDiaryScene(_ aScene: DiarySceneDelegate) {
        diaryScene = aScene
        diaryScene?.setController(controller: self)
        view = diaryScene as? UIView
    }
    
    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        coreDataManager = aCoreData
    }
    
    func saveFood(ingestedFood: [FoodOff], noIngestedFood: [FoodOff]) {
        guard let coreDataManager = coreDataManager,
              let today: Day = createToday() else { return }
        today.removeFromIngested(NSSet(array: noIngestedFood))
        today.addToIngested(NSSet(array: ingestedFood))
        today.removeFromNoIngested(NSSet(array: ingestedFood))
        today.addToNoIngested(NSSet(array: noIngestedFood))
        coreDataManager.save()
        let days: [Day] = coreDataManager.fetch()
        print(days)
    }
    
    private func createToday() -> Day? {
        let calendar = Calendar(identifier: .gregorian)
        guard let coreDataManager = coreDataManager else { return nil }
        let days: [Day] = coreDataManager.fetch()
       
        let daySelected = calendar.component(.day, from: Date())
        let monthSelected = calendar.component(.month, from:  Date())
        let yearSelected = calendar.component(.year, from:  Date())
        
        var validator: Bool = false
        var today: Day?
        days.forEach {
            if let dayDate = $0.date {
                if daySelected == calendar.component(.day, from: dayDate) &&
                   monthSelected == calendar.component(.month, from: dayDate) &&
                   yearSelected == calendar.component(.year, from: dayDate) {
                    validator = true
                    today = $0
                }
            }
        }
        
        if !validator {
            let today: Day = coreDataManager.createEntity()
            let foods: [FoodOff] = coreDataManager.fetch()
            today.date = Date()
            today.addToFoods(NSSet(array: foods))
            coreDataManager.save()
            return today
        }
        
        return today
    }

    func fetchDayAll() {
        guard let coreDataManager = coreDataManager else { return }
        let days: [Day] = coreDataManager.fetch()
        diaryScene?.setDayAll(days: days)
    }
    
    func fetchFoodAll() {
        guard let coreDataManager = coreDataManager else { return }
        let foods: [FoodOff] = coreDataManager.fetch()
        diaryScene?.setFoodAll(foods: foods)
    }
    
    func fetchUser() {
        guard let coreDataManager = coreDataManager else { return }
        let user: [User] = coreDataManager.fetch()
        diaryScene?.setUser(user: user.first)
    }
}
