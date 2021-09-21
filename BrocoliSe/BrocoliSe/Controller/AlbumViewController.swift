//
//  AlbumViewController.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import Foundation
import UIKit

class AlbumViewController: UIViewController {
    
    private let scene = AlbumScene(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupSceneConstraints()
        self.setupNavigationBar()
    }
    
    private func setupSceneConstraints() {
        scene.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.addSubview(scene)
        NSLayoutConstraint.activate([
            scene.topAnchor.constraint(equalTo: view.topAnchor),
            scene.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scene.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scene.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "Álbum"
        
        let attrs = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.graviolaRegular(size: 34) ?? UIFont.systemFont(ofSize: 34)
        ]
        
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = attrs
    }
    
}
