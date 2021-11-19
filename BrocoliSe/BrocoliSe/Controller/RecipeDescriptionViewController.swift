//
//  RecipeDescriptionViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

protocol RecipeDescriptionSceneDelegate: AnyObject {
    func setController(controller: RecipeDescriptionViewController)
}

class RecipeDescriptionViewController: UIViewController {
    
    private var scene: RecipeDescriptionSceneDelegate?
    var tabCoordinator: TabCoordinatorProtocol?
    
    override func viewWillAppear(_ animated: Bool) {
        tabCoordinator?.configTabBar(color: .white)
        configNavBar()
    }
    
    private func configNavBar() {
        self.navigationController?.navigationBar.backgroundColor = .clear

        let backButtonImage = UIImage(named: "backButton")?.withRenderingMode(.alwaysOriginal)
        let saveButtonImage = UIImage(named: "saveButton")?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: backButtonImage, style: .plain, target: self, action: #selector(popSelf))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: saveButtonImage, style: .plain, target: self, action: #selector(saveRecipe))
    }
    
    @objc private func popSelf() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func saveRecipe() {
        navigationItem.rightBarButtonItem?.image = UIImage(named: "saveButton.fill")?.withRenderingMode(.alwaysOriginal)
    }
    
    func setRecipeDescriptionScene(_ recipeDescriptionScene: RecipeDescriptionSceneDelegate) {
        scene = recipeDescriptionScene
        scene?.setController(controller: self)
        view = scene as? UIView
    }
}
