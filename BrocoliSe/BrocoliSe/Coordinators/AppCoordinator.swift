import Foundation
import UIKit

protocol AppCoordinatorProtocol: Coordinator {
    func showOnboardingFlow()
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .appInitial }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: true)
    }
    
    func start() {
        //showOnboardingFlow()
        showMainFlow()
    }
    
    func showOnboardingFlow() {
        let onboardingCoodinator = OnboardingCoordinator(navigationController: navigationController)
        onboardingCoodinator.finishDelegate = self
        onboardingCoodinator.start()
        childCoordinators.append(onboardingCoodinator)
        
    }
    
    func showMainFlow() {
        let tabCoordinator = TabCoordinator(navigationController: navigationController)
            tabCoordinator.finishDelegate = self
            tabCoordinator.start()
            childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        switch childCoordinator.type {
        case .onboarding:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        default:
            break
        }
    }
}
