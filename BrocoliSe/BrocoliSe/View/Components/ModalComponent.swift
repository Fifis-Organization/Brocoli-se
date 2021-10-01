//
//  ModalComponent.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 20/09/21.
//

import UIKit

class ModalComponent: UIView {

    var dismissViewController: () -> Void  = { }

    private let maxDimmedAlpha: CGFloat = 0.6

    private let defaultHeight: CGFloat = UIScreen.main.bounds.height * 0.66
    private let dismissibleHeight: CGFloat = UIScreen.main.bounds.height * 0.4
    private var currentContainerHeight: CGFloat = UIScreen.main.bounds.height * 0.66

    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    lazy var dimmedView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = maxDimmedAlpha
        return view
    }()

    private var containerViewHeightConstraint: NSLayoutConstraint?
    private var containerViewBottomConstraint: NSLayoutConstraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        self.backgroundColor = .clear
    }

    private func setupConstraints() {
        self.addSubview(dimmedView)
        self.addSubview(containerView)
        dimmedView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            dimmedView.topAnchor.constraint(equalTo: self.topAnchor),
            dimmedView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            dimmedView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dimmedView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])

        containerViewHeightConstraint = containerView.heightAnchor.constraint(equalToConstant: defaultHeight)
        containerViewHeightConstraint?.isActive = true
    }

    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = 0
            self.layoutIfNeeded()
        }
    }

    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }

    private func animateDismissView() {
        UIView.animate(withDuration: 0.3) {
            self.containerViewBottomConstraint?.constant = self.defaultHeight
            self.layoutIfNeeded()
        }

        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
        } completion: { _ in
            self.dismissViewController()
        }
    }

    func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))

        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false

        self.addGestureRecognizer(panGesture)
    }

    private func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.containerViewHeightConstraint?.constant = height
            self.layoutIfNeeded()
        }
        currentContainerHeight = height
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y

        print("Pan gesture y offset: \(translation.y)")
        switch gesture.state {
        case .changed:
            if newHeight < defaultHeight {
                containerViewHeightConstraint?.constant = newHeight
                self.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                self.animateDismissView()
            } else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            } else if newHeight < defaultHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
        default:
            break
        }
    }
}
