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
}

class RecipeListViewController: UIViewController {

    private var scene: RecipeListSceneDelegate?

    var tabCoordinator: TabCoordinatorProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
        tabCoordinator?.configTabBar(color: .white)
    }

    func setRecipeListScene(_ recipeListScene: RecipeListSceneDelegate) {
        scene = recipeListScene
        scene?.setController(controller: self)
        view = scene as? UIView
    }
}
