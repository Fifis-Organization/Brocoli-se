//
//  ViewController.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit

class ViewController: UIViewController {
    private let scene = DiaryScene(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        scene.translatesAutoresizingMaskIntoConstraints = false
        view.insetsLayoutMarginsFromSafeArea = false
        view.addSubview(scene)
        NSLayoutConstraint.activate([
            scene.topAnchor.constraint(equalTo: view.topAnchor),
            scene.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scene.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scene.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
