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
    private var isSave = false
    
    override func viewWillAppear(_ animated: Bool) {
        tabCoordinator?.configTabBar(color: .white)
        configNavBar()
    }
    
    private func configNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .clear
        
        let backButtonImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)

        if fetchValidate() {
            removeSaveButton()
        } else {
            saveButton()
        }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(popSelf))
    }
    
    private func saveButton() {
        let saveButtonImage = UIImage(named: "saveButton")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: saveButtonImage, style: .plain, target: self, action: #selector(saveRecipe))
    }
    
    private func removeSaveButton() {
        let saveButtonImage = UIImage(named: "saveButton.fill")?.withRenderingMode(.alwaysOriginal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: saveButtonImage, style: .plain, target: self, action: #selector(removeRecipe))
    }
    
    private func fetchValidate() -> Bool{
        let recipes: [Recipe] = coredateManager.fetch()
        if let recipeModel = recipeCoordinator?.getRecipes() {
           return recipes.contains(where: {$0.id == recipeModel.idRecipe})
        }
        return false
    }
    
    @objc private func popSelf() {
        navigationController?.popViewController(animated: false)
        if isSave {
            if !fetchValidate() {
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
        } else {
            let recipeModel = recipeCoordinator?.getRecipes()?.idRecipe as? NSString ?? ""
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Recipe.entityName)
            request.predicate = NSPredicate.init(format: "id==%@", recipeModel)
            coredateManager.removeEntity(request: request)
        }
    }
    
    @objc private func saveRecipe() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "saveButton.fill")?.withRenderingMode(.alwaysOriginal)
        isSave = true
        removeSaveButton()
    }
    
    @objc private func removeRecipe() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "saveButton")?.withRenderingMode(.alwaysOriginal)
        isSave = false
        saveButton()
    }
    
    func setRecipeDescriptionScene(_ recipeDescriptionScene: RecipeDescriptionSceneDelegate) {
        scene = recipeDescriptionScene
        scene?.setController(controller: self)
        view = scene as? UIView
    }
}
