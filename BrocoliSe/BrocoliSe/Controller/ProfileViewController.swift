//
//  ProfileViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var scene: ProfileSceneDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setProfileScene(_ scene: ProfileSceneDelegate) {
        self.scene = scene
        self.view = scene as? UIView
    }
}
