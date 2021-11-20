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
    func getRecipes() -> RecipeCellModel?
}

class RecipeCoordinator: RecipeCoodinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType {.settings}
    var tabCoordinator: TabCoordinator?
    private var recipe: RecipeCellModel?
    
    init (navigationController: UINavigationController, recipe: RecipeCellModel) {
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
        recipeDescriptionVC.recipeCoordinator = self
        navigationController.pushViewController(recipeDescriptionVC, animated: true)
    }
    
    func getRecipes() -> RecipeCellModel? {
        return recipe
    }
}
