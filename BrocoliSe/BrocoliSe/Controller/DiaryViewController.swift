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
    func setDay(daySelected: Day?)
    func presenterModal(_ modal: ModalViewController)
    func setupDatas()
    func setTextLabelProgress(_ text: String)
}

class DiaryViewController: UIViewController {
    private var diaryScene: DiarySceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?

    var tabCoordinator: TabCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabCoordinator?.configTabBar(color: .white)
    }

    func setDiaryScene(_ aScene: DiarySceneDelegate) {
        diaryScene = aScene
        diaryScene?.setController(controller: self)
        view = diaryScene as? UIView
        diaryScene?.setDay(daySelected: createToday())
    }
    
    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        coreDataManager = aCoreData
    }
    
    func saveFood(ingestedFood: [FoodOff], noIngestedFood: [FoodOff], today: Day) {
        guard let coreDataManager = coreDataManager else { return }
    
        today.removeFromIngested(NSSet(array: noIngestedFood))
        today.addToIngested(NSSet(array: ingestedFood))
        
        today.removeFromNoIngested(NSSet(array: ingestedFood))
        today.addToNoIngested(NSSet(array: noIngestedFood))
        
        let user: [User] = coreDataManager.fetch()
        if noIngestedFood.isEmpty {
            today.concluded = true
            user.first?.point += 10
        } else {
            if today.concluded {
                user.first?.point -= 10
            }
            today.concluded = false
        }
        fetchUser()
        coreDataManager.save()
        if user.first?.point == 100 && today.concluded {
            let modalVC = ModalViewController()
            modalVC.tabCoordinator = self.tabCoordinator
            modalVC.modalPresentationStyle = .overFullScreen
            self.present(modalVC, animated: false)
        }
    }
    
    func createToday() -> Day? {
        let calendar = Calendar(identifier: .gregorian)
        guard let coreDataManager = coreDataManager else { return nil }
        let days: [Day] = coreDataManager.fetch()
        
        let daySelected = calendar.component(.day, from: Date())
        let monthSelected = calendar.component(.month, from: Date())
        let yearSelected = calendar.component(.year, from: Date())
        
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
            today.addToNoIngested(NSSet(array: foods))
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
    
    func fetchDay(_ date: Date) {
        let calendar = Calendar(identifier: .gregorian)
        guard let coreDataManager = coreDataManager else { return }
        let days: [Day] = coreDataManager.fetch()
        
        let daySelected = calendar.component(.day, from: date)
        let monthSelected = calendar.component(.month, from: date)
        let yearSelected = calendar.component(.year, from: date)
        
        var validator = false
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
        
        validator ? diaryScene?.setDay(daySelected: today) : diaryScene?.setDay(daySelected: nil)
    }
}
