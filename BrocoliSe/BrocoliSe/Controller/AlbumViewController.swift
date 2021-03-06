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
    func reloadCollection()
}

class AlbumViewController: UICollectionViewController {
    
    private var scene: AlbumSceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?
    var tabCoordinator: TabCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.scene?.reloadCollection()
        tabCoordinator?.configTabBar(color: .white.withAlphaComponent(0.08))
    }
    
    func setAlbumScene(_ scene: AlbumSceneDelegate) {
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
        self.scene?.reloadCollection()
    }
}
