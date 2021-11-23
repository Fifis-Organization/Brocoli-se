//
//  SceneDelegate.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.overrideUserInterfaceStyle = .light 
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        
        appCoordinator = AppCoordinator(navigationController: navigationController)
        appCoordinator?.start()
        
        window?.makeKeyAndVisible()
        
        connectionOptions.userActivities.forEach { userAct in 
            dealWithUserActivities(userActivity: userAct, isContinuing: false)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        dealWithUserActivities(userActivity: userActivity, isContinuing: true)
        
        guard let intent = userActivity.interaction?.intent as? RecipeIntent,
                let recipe = intent.name else {
                    return
        }
        guard let tabBarCoordinator = appCoordinator?.childCoordinators.first as? TabCoordinator else {return}
        tabBarCoordinator.setSelectedIndex(2)
        guard let tabBarCoordinator = appCoordinator?.childCoordinators.first as? TabCoordinator,
              let recipeVC = tabBarCoordinator.controllers.last?.viewControllers.first as? RecipeListViewController else {return}
        recipeVC.scene?.setupSiriResearch(recipe: recipe)
    }
    
    fileprivate func openAlbum() {
        guard let tabBarCoordinator = appCoordinator?.childCoordinators.first as? TabCoordinator else {return}
        tabBarCoordinator.setSelectedIndex(1)
    }
    
    fileprivate func checkList() {
        guard let tabBarCoordinator = appCoordinator?.childCoordinators.first as? TabCoordinator,
              let diaryVC = tabBarCoordinator.controllers.first?.viewControllers.first as? DiaryViewController else {return}
        tabBarCoordinator.setSelectedIndex(0)
        diaryVC.diaryScene?.setupSiri()
    }
    
    func dealWithUserActivities(userActivity: NSUserActivity, isContinuing: Bool) {
        switch userActivity.activityType {
        case SiriActivitiesType.checkListActivity.rawValue:
            checkList()
        case SiriActivitiesType.albumActivity.rawValue:
            openAlbum()
        default:
            break
        }
    }

}
