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
}

class SettingsCoordinator: SettingsCoodinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.profile}
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showSettingsViewController()
    }
    
    func showSettingsViewController() {
        let settingsVC = FactoryControllers.createSettingsViewController()
        navigationController.pushViewController(settingsVC, animated: false)
    }
    
}
