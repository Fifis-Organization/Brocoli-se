//
//  ModalViewController.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 20/09/21.
//

import UIKit

class ModalViewController: UIViewController {

    private let scene = RewardModalScene(frame: UIScreen.main.bounds)
    weak var tabCoordinator: TabCoordinatorProtocol?

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
        view = scene
        scene.viewController = self
        scene.modal.setupPanGesture()
    }
}
