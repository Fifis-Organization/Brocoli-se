//
//  OnboardingCoordinator.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import Foundation
import UIKit

protocol OnboardingCoodinatorProtocol: Coordinator {
    func showOnboardingViewController()
}

class OnboardingCoordinator: OnboardingCoodinatorProtocol {
    
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
        let onboardingVC = OnboardingViewController()
        onboardingVC.didSendContinue = { [weak self] in
            self?.finish()
        }
        navigationController.pushViewController(onboardingVC, animated: false)
        
    }
    
}
