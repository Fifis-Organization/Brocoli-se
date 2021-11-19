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
    private var recipe: RecipeModel?
    
    init (navigationController: UINavigationController, recipe: RecipeModel) {
        self.navigationController = navigationController
        self.recipe = recipe
    }
    
    func start() {
        showRecipeDescriptionViewController()
    }
    
    func showRecipeDescriptionViewController() {
        guard let recipe = self.recipe else { return }
        let recipeDescriptionVC = FactoryControllers.createRecipeDescriptionViewController(recipe: recipe)
        recipeDescriptionVC.tabCoordinator = tabCoordinator
        navigationController.pushViewController(recipeDescriptionVC, animated: true)
    }
}
