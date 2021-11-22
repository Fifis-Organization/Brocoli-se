//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Larissa Uchoa on 26/10/21.
//

import UIKit
import CoreData

protocol ProfileSceneDelegate: AnyObject {
    func setController(controller: ProfileViewController)
    func setUser(user: User?)
    func setupDatas()
    func updatedImage() -> Data?
    func getTextFieldName() -> String
    func setSelectedFood(selectedFood: [String])
    func getSelectedFood() -> [String]
}

class ProfileViewController: UIViewController {
    private var scene: ProfileSceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationStyle()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disconfigureNavigationStyle()
    }

    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        self.coreDataManager = aCoreData
    }

    func fetchUser() {
        guard let coreDataManager = coreDataManager else { return }
        let user: [User] = coreDataManager.fetch()
        scene?.setUser(user: user.first)
    }

    func fetchFood() {
        guard let coreDataManager = coreDataManager else { return }
        let foods: [FoodOff] = coreDataManager.fetch()
        var selectedFood: [String] = []
        foods.forEach { food in
            selectedFood.append(food.food ?? "")
        }
        scene?.setSelectedFood(selectedFood: selectedFood)
    }

    func setProfileScene(_ scene: ProfileSceneDelegate) {
        self.scene = scene
        self.scene?.setController(controller: self)
        self.view = scene as? UIView
    }

    private func configureNavigationStyle() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.blueDark,
            NSAttributedString.Key.font: UIFont.graviolaSoft(size: 34) ?? UIFont.systemFont(ofSize: 34)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attrs as [NSAttributedString.Key : Any]
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(saveUser))
    }

    private func disconfigureNavigationStyle() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @objc func saveUser() {
        guard let coreDataManager = coreDataManager else { return }
        let user: [User] = coreDataManager.fetch()
        user.first?.icon = scene?.updatedImage()
        user.first?.name = scene?.getTextFieldName()

        let selectedFoods = scene?.getSelectedFood()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: FoodOff.entityName)
        coreDataManager.removeEntity(request: request)
        
        var foods: [FoodOff] = []
        
        selectedFoods?.forEach {
            let food: FoodOff = coreDataManager.createEntity()
            food.food = $0
            foods.append(food)
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let days: [Day] = coreDataManager.fetch()
        let daySelected = calendar.dateComponents([.day, .month, .year], from: Date())
        
        var today: Day?
        days.forEach {
            if let dayDate = $0.date {
                if daySelected.day == calendar.component(.day, from: dayDate) &&
                    daySelected.month == calendar.component(.month, from: dayDate) &&
                    daySelected.year == calendar.component(.year, from: dayDate) {
                    today = $0
                }
            }
        }
        
        if let today = today,
           let todayFoods = today.foods {
            today.removeFromFoods(todayFoods)
            if let ingested = today.ingested {
                today.removeFromIngested(ingested)
            }
            if let noIngested = today.noIngested {
                today.removeFromNoIngested(noIngested)
            }
            if today.concluded {
                user.first?.point -= 10
                today.concluded = false
            }
            today.addToFoods(NSSet(array: foods))
            today.addToNoIngested(NSSet(array: foods))
            today.addToIngested(NSSet(array: []))
        }
        coreDataManager.save()
    }
}
