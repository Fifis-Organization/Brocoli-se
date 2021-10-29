//
//  ProfileViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var scene: SettingsSceneDelegate?
    var settingsCoodinator: SettingsCoodinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = .greenMedium
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationBar.barStyle = .black
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        settingsCoodinator?.finish()
    }
    
    func setProfileScene(_ scene: SettingsSceneDelegate) {
        self.scene = scene
        self.scene?.setController(controller: self)
        self.view = scene as? UIView
    }
}
