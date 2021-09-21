//
//  RewardModalScene.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 20/09/21.
//

import UIKit

class RewardModalScene: UIView {

    weak var viewController: ModalViewController?

    let modal: ModalComponent = {
        let modal = ModalComponent()
        modal.containerView.backgroundColor = .backgroundColor
        modal.translatesAutoresizingMaskIntoConstraints = false
        return modal
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Parabéns!"
        label.font = .graviolaSoft(size: 24)
        label.textColor = .blueDark
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var brocolisImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "brocolis-animado")
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Você desbloqueou uma nova figurinha."
        label.font = .graviolaRegular(size: 18)
        label.textColor = .blueDark
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontForContentSizeCategory = true
        return label
    }()

    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [titleLabel, brocolisImage, textLabel, buttonStackView, spacer])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Agora não", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .graviolaRegular(size: 16)
        button.backgroundColor = .redCustom
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()

    private let albumButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ver no álbum", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .graviolaRegular(size: 16)
        button.backgroundColor = .greenMedium
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(goToAlbum), for: .touchUpInside)
        return button
    }()

    private lazy var buttonStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [cancelButton, albumButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 24
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        modal.dismissViewController = {
            self.viewController?.dismiss(animated: false)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        self.addSubview(modal)
        modal.containerView.addSubview(contentStackView)

        NSLayoutConstraint.activate([
            modal.topAnchor.constraint(equalTo: self.topAnchor),
            modal.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            modal.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            modal.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            brocolisImage.heightAnchor.constraint(equalTo: contentStackView.heightAnchor, multiplier: 0.35),
            brocolisImage.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.38),

            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            cancelButton.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.4),
            albumButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor),
            albumButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor),

            contentStackView.topAnchor.constraint(equalTo: modal.containerView.topAnchor, constant: 32),
            contentStackView.bottomAnchor.constraint(equalTo: modal.containerView.bottomAnchor, constant: -20),
            contentStackView.leadingAnchor.constraint(equalTo: modal.containerView.leadingAnchor, constant: 20),
            contentStackView.trailingAnchor.constraint(equalTo: modal.containerView.trailingAnchor, constant: -20)
        ])
    }

    @objc func cancel() {
        self.viewController?.dismiss(animated: false)
    }

    @objc func goToAlbum() {
        // MARK: Add push to album view controller
    }
}
