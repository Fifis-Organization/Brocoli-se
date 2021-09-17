import UIKit
import Foundation

protocol Coordinator: class {
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
   
    var type: CoordinatorType { get }
    
    func start()
    func finish()
}

extension Coordinator {
    func finish() {
        childCoordinators.removeAll()
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
}

protocol CoordinatorFinishDelegate: class {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    case appInitial, onboarding, tabBar
}
