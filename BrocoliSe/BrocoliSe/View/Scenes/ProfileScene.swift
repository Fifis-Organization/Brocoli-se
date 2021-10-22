//
//  PerfilScene.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

protocol ProfileSceneDelegate: AnyObject {
    
}

class ProfileScene: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileScene: ProfileSceneDelegate {
    
}
