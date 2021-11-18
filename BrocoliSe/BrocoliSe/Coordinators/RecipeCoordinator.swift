//
//  RecipeCoordinator.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import Foundation
import UIKit

protocol RecipeCoodinatorProtocol: Coordinator {
    func showRecipeDescriptionViewController()
}

class RecipeCoordinator: RecipeCoodinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType {.settings}
    var tabCoordinator: TabCoordinator?
    
    init (navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showRecipeDescriptionViewController()
    }
    
    func showRecipeDescriptionViewController() {
        let recipeDescriptionVC = FactoryControllers.createRecipeDescriptionViewController()
        recipeDescriptionVC.tabCoordinator = tabCoordinator
        navigationController.pushViewController(recipeDescriptionVC, animated: true)
    }
}
