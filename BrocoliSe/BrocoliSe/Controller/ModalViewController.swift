//
//  ModalViewController.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 20/09/21.
//

import UIKit

class ModalViewController: UIViewController {

    private let scene = RewardModalScene(frame: UIScreen.main.bounds)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.insetsLayoutMarginsFromSafeArea = false
        navigationController?.navigationBar.isHidden = true

        setupScene()
    }

    override func viewDidAppear(_ animated: Bool) {
        scene.modal.animateShowDimmedView()
        scene.modal.animatePresentContainer()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    private func setupScene() {
        view.addSubview(scene)
        scene.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scene.topAnchor.constraint(equalTo: view.topAnchor),
            scene.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scene.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scene.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scene.viewController = self
        scene.modal.setupPanGesture()
    }
}
