//
//  OnboardingCoordinator.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import Foundation
import UIKit

protocol ProfileCoodinatorProtocol: Coordinator {
    func showOnboardingViewController()
}

class OnboardingCoordinator: ProfileCoodinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var childCoordinators: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    var type: CoordinatorType {.onboarding}
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showOnboardingViewController()
    }
    
    func showOnboardingViewController() {
        let onboardingVC = FactoryControllers.createOnboardingViewController()
        onboardingVC.didSendContinue = { [weak self] in
            self?.finish()
        }
        navigationController.pushViewController(onboardingVC, animated: false)
    }
    
}
