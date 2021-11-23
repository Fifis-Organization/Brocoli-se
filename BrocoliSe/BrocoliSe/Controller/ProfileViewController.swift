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
    func shakeFoodSelected()
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
    
    private func alertConfirm(message: String) {
        let alert = UIAlertController(title: "Olá", message: message, preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "Entendi", style: UIAlertAction.Style.default, handler: nil))
        alert.view.tintColor = .greenMedium
        self.present(alert, animated: true)
    }
    
    // swiftlint:disable function_body_length
    @objc func saveUser() {
        if scene?.getSelectedFood().isEmpty ?? true {
            scene?.shakeFoodSelected()
            alertConfirm(message: "Você deve escolher algum alimento!")
            return
        }
        
        let coredataManager = CoreDataManager(dataModelType: .check)
        let user: [User] = coredataManager.fetch()
        user.first?.icon = scene?.updatedImage()
        user.first?.name = scene?.getTextFieldName()

        let selectedFoods = scene?.getSelectedFood()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: FoodOff.entityName)
        coredataManager.removeEntity(request: request)
        
        var foods: [FoodOff] = []
        
        selectedFoods?.forEach {
            let food: FoodOff = coredataManager.createEntity()
            food.food = $0
            foods.append(food)
        }
        
        let calendar = Calendar(identifier: .gregorian)
        let days: [Day] = coredataManager.fetch()
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
        
        coredataManager.save()
        alertConfirm(message: "Suas alterações foram salvas!")
    }
}
