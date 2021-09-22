//
//  AlbumViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import Foundation
import UIKit

protocol AlbumSceneDelegate: AnyObject {
    func setController(controller: AlbumViewController)
    func setUser(user: User?)
    func setupDatas()
}

class AlbumViewController: UIViewController {
    
    private var scene: AlbumSceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // self.setupSceneConstraints()
        // self.setupNavigationBar()
    }
    
    func setAlbumScene(_ scene: AlbumSceneDelegate) {
        self.scene = scene
        self.scene?.setController(controller: self)
        self.view = scene as? UIView
    }
    
    func setCoreDataManager(_ aCoreData: CoreDataManagerProtocol) {
        self.coreDataManager = aCoreData
    }
    
//    private func setupSceneConstraints() {
//        guard let scene = scene as? UIView else { return }
//        scene.translatesAutoresizingMaskIntoConstraints = false
//        view.insetsLayoutMarginsFromSafeArea = false
//        view.addSubview(scene)
//        NSLayoutConstraint.activate([
//            scene.topAnchor.constraint(equalTo: view.topAnchor),
//            scene.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            scene.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            scene.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
//    }
    
//    private func setupNavigationBar() {
//        self.navigationItem.title = "Álbum"
//
//        let attrs = [
//            NSAttributedString.Key.foregroundColor: UIColor.white,
//            NSAttributedString.Key.font: UIFont.graviolaRegular(size: 34) ?? UIFont.systemFont(ofSize: 34)
//        ]
//
//        navigationItem.largeTitleDisplayMode = .always
//        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.navigationBar.largeTitleTextAttributes = attrs
//    }
    
    func fetchUser() {
        guard let coreDataManager = coreDataManager else { return }
        let user: [User] = coreDataManager.fetch()
        scene?.setUser(user: user.first)
    }
    
}
