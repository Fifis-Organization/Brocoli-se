//
//  ViewController.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

protocol DiarySceneDelegate: class {
    func getDayAll(days: [Day])
    func getFoodAll(foods: [FoodOff])
    func setController(controller: ViewController)
    func setupDatas()
}

class ViewController: UIViewController {
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
        diaryScene?.setupDatas()
    }
    
    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        coreDataManager = aCoreData
        //testCore()
    }
    
    func fetchFoodAll() {
        guard let coreDataManager = coreDataManager else { return }
        let foods: [FoodOff] = coreDataManager.fectch()
        diaryScene?.getFoodAll(foods: foods)
    }
    
    func testCore() {
        guard let coreDataManager = coreDataManager else { return }
        let food01: FoodOff = coreDataManager.createEntity()
        food01.food = FoodNames.carne
        let food02: FoodOff = coreDataManager.createEntity()
        food02.food = FoodNames.ovos
        let food03: FoodOff = coreDataManager.createEntity()
        food03.food = FoodNames.frango
        
        coreDataManager.saveSync()
    }
}
