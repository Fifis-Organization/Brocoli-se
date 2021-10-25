//
//  ProfileViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private var scene: SettingsSceneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setProfileScene(_ scene: SettingsSceneDelegate) {
        self.scene = scene
        self.view = scene as? UIView
    }
}
