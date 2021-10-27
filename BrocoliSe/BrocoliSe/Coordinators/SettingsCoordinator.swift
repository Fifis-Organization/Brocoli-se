//
//  ProfileCoordinator.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import Foundation
import UIKit

protocol SettingsCoodinatorProtocol: Coordinator {
    func showSettingsViewController()
    func showProfileViewController()
}

class SettingsCoordinator: SettingsCoodinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType {.settings}
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSettingsViewController()
    }
    
    func showSettingsViewController() {
        let settingsVC = FactoryControllers.createSettingsViewController()
        settingsVC.settingsCoodinator = self
        navigationController.pushViewController(settingsVC, animated: true)
    }
    
    func showProfileViewController() {
        
    }
    
}
