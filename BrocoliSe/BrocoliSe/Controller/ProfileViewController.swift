//
//  ProfileViewController.swift
//  ProfileViewController
//
//  Created by Larissa Uchoa on 26/10/21.
//

import UIKit

protocol ProfileSceneDelegate: AnyObject {
    func setController(controller: ProfileViewController)
    func setUser(user: User?)
    func setupDatas()
}

class ProfileViewController: UIViewController {
    private var profileScene: ProfileScene = ProfileScene()
    private var scene: ProfileSceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        profileScene.setController(controller: self)
        self.view = profileScene
        title = "Perfil"
    }

    func setProfileScene(_ scene: ProfileSceneDelegate) {
        self.scene = scene
        self.scene?.setController(controller: self)
        self.view = scene as? UIView
    }

    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        self.coreDataManager = aCoreData
    }

    func fetchUser() {
        guard let coreDataManager = coreDataManager else { return }
        let user: [User] = coreDataManager.fetch()
        scene?.setUser(user: user.first)
    }

    func reload() {

    }
}
