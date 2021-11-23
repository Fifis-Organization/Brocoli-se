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
    func setupSiriResearch(recipe: String)
    func setupViewState(from viewState: ViewState)
    func setupDatas()
}

class RecipeListViewController: UIViewController {

    var scene: RecipeListSceneDelegate?

    var tabCoordinator: TabCoordinatorProtocol?
    
    var apiManager: ApiManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        scene?.setupDatas()
        tabCoordinator?.configTabBar(color: .white)
        navigationController?.navigationBar.backgroundColor = .blueDark
        scene?.reloadTable()
    }

    func setRecipeListScene(_ recipeListScene: RecipeListSceneDelegate) {
        scene = recipeListScene
        scene?.setController(controller: self)
        view = scene as? UIView
        fetchRecipesApi()
    }
    
    func fetchRecipesApi() {
        self.scene?.setupViewState(from: .load)
        DispatchQueue.main.async {
            self.apiManager?.fetch(request: Endpoints.getRecipes, model: RecipeModel.self) { result in
                switch result {
                case .success(let models):
                    self.scene?.setupViewState(from: .content(models: models))
                case .failure(_):
                    self.scene?.setupViewState(from: .error)
                }
            }
        }
    }
    
}
