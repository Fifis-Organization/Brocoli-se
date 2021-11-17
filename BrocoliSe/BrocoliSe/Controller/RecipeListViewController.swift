//
//  RecipeListViewController.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 09/11/21.
//

import UIKit

protocol RecipeListSceneDelegate: AnyObject {
    func setController(controller: RecipeListViewController)
    func reloadTable()
    func setRecipes(recipes: [RecipeModel])
}

class RecipeListViewController: UIViewController {

    private var scene: RecipeListSceneDelegate?

    var tabCoordinator: TabCoordinatorProtocol?
    
    var apiManager: ApiManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setRecipeListScene(_ recipeListScene: RecipeListSceneDelegate) {
        scene = recipeListScene
        scene?.setController(controller: self)
        view = scene as? UIView
        fetchRecipesApi()
    }
    
    func fetchRecipesApi() {
        DispatchQueue.main.async {
            self.apiManager?.fetch(request: Endpoints.getRecipes, model: RecipeModel.self) { result in
                switch result {
                case .success(let models):
                     self.scene?.setRecipes(recipes: models)
                case .failure(_):
                    print("Error")
                }
            }
        }
    }
    
}
