//
//  LabelWithLeftImage.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 09/11/21.
//

import UIKit

class LabelWithLeftImage: UIView {

    private lazy var leftImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.font = .graviolaRegular(size: 14)
        label.textColor = .blueDark?.withAlphaComponent(0.8)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var contentStack: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [leftImage,
                                                       label,
                                                       spacer])
        stackView.axis = .horizontal
        stackView.spacing = 10.0
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    init(frame: CGRect, image: UIImage) {
        super.init(frame: frame)
        self.leftImage.image = image
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        addSubview(contentStack)

        NSLayoutConstraint.activate([
            contentStack.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStack.topAnchor.constraint(equalTo: self.topAnchor)
        ])
    }

    func setLabelText(text: String) {
        label.text = text
    }
}
