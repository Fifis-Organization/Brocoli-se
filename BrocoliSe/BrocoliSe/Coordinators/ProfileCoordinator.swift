//
//  ProfileCoordinator.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import Foundation
import UIKit

protocol ProfileCoodinatorProtocol: Coordinator {
    func showProfileViewController()
}

class ProfileCoordinator: ProfileCoodinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.profile}
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showProfileViewController()
    }
    
    func showProfileViewController() {
        let profileVC = FactoryControllers.createProfileViewController()
        navigationController.pushViewController(profileVC, animated: false)
    }
    
}

