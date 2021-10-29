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
    private var scene: ProfileSceneDelegate?
    private var coreDataManager: CoreDataManagerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationStyle()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        disconfigureNavigationStyle()
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

    private func configureNavigationStyle() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.blueDark,
            NSAttributedString.Key.font: UIFont.graviolaSoft(size: 34) ?? UIFont.systemFont(ofSize: 34)
        ]
        navigationController?.navigationBar.largeTitleTextAttributes = attrs as [NSAttributedString.Key : Any]
    }

    private func disconfigureNavigationStyle() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
    }
}
