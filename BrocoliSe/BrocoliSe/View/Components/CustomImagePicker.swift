//
//  CustomImagePicker.swift
//  CustomImagePicker
//
//  Created by Larissa Uchoa on 26/10/21.
//

import UIKit

protocol SelectPhotoDelegate: AnyObject {
    func didTapSelectPhoto()
}

class CustomImagePicker: UIView {
    weak var selectPhotoDelegate: SelectPhotoDelegate?

    private let profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit
        imgView.image = UIImage(named: "brocolis-animado")
        imgView.clipsToBounds = true
        return imgView
    }()

    private let selectPhotoButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .graviolaRegular(size: 18)
        button.setTitle("Selecionar foto", for: .normal)
        button.setTitleColor(.greenMedium, for: .normal)
        button.addTarget(self, action: #selector(selectPhoto), for: .touchUpInside)
        return button
    }()

    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [profileImageView, selectPhotoButton, spacer])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 20.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(contentStackView)

        NSLayoutConstraint.activate([
            contentStackView.widthAnchor.constraint(equalTo: widthAnchor),
            contentStackView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
    }

    @objc func selectPhoto() {
        selectPhotoDelegate?.didTapSelectPhoto()
    }

    func setNewPhoto(image: UIImage) {
        self.profileImageView.image = image
    }
}
