//
//  RecipeDescriptionViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit
import CoreData

protocol RecipeDescriptionSceneDelegate: AnyObject {
    func setController(controller: RecipeDescriptionViewController)
}

class RecipeDescriptionViewController: UIViewController {
    
    private var scene: RecipeDescriptionSceneDelegate?
    var tabCoordinator: TabCoordinatorProtocol?
    var recipeCoordinator: RecipeCoordinator?
    let coredateManager = CoreDataManager(dataModelType: .recipe)
    
    override func viewWillAppear(_ animated: Bool) {
        tabCoordinator?.configTabBar(color: .white)
        configNavBar()
    }
    
    private func configNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        let backButtonImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
        var saveButtonImage = UIImage(named: "saveButton")?.withRenderingMode(.alwaysOriginal)
        
        var validate = false
        let recipes: [Recipe] = coredateManager.fetch()
        if let recipeModel = recipeCoordinator?.getRecipes() {
            validate = recipes.contains(where: {$0.id == recipeModel.idRecipe})
        }
        if validate {
            saveButtonImage = UIImage(named: "saveButton.fill")?.withRenderingMode(.alwaysOriginal)
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(popSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: saveButtonImage, style: .plain, target: self, action: validate ? #selector(removeRecipe) : #selector(saveRecipe))
    }
    
    @objc private func popSelf() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func saveRecipe() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "saveButton.fill")?.withRenderingMode(.alwaysOriginal)
        let recipeModel = recipeCoordinator?.getRecipes()
        let recipe: Recipe = coredateManager.createEntity()
        recipe.id = recipeModel?.idRecipe
        recipe.nome = recipeModel?.name
        recipe.porcoes = recipeModel?.portions
        recipe.tempo = recipeModel?.time
        recipe.pathFoto = recipeModel?.pathPhoto?.pngData()
        recipe.pathFotoString = recipeModel?.pathPhotoString
        
        var ingredients: [Ingredient] = []
        recipeModel?.ingredients.forEach {
            let ingredient: Ingredient = coredateManager.createEntity()
            ingredient.ingredient = $0
            ingredients.append(ingredient)
        }
        
        var steps: [Steps] = []
        recipeModel?.steps.forEach {
            let step: Steps = coredateManager.createEntity()
            step.step = $0
            steps.append(step)
        }
        
        recipe.addToIngredients(NSSet(array: ingredients))
        recipe.addToSteps(NSSet(array: steps))
        coredateManager.save()
    }
    
    @objc private func removeRecipe() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "saveButton")?.withRenderingMode(.alwaysOriginal)
        let recipeModel = recipeCoordinator?.getRecipes()?.idRecipe as? NSString ?? ""
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: Recipe.entityName)
        request.predicate = NSPredicate.init(format: "id==%@", recipeModel)
        coredateManager.removeEntity(request: request)
    }
    
    func setRecipeDescriptionScene(_ recipeDescriptionScene: RecipeDescriptionSceneDelegate) {
        scene = recipeDescriptionScene
        scene?.setController(controller: self)
        view = scene as? UIView
    }
}
