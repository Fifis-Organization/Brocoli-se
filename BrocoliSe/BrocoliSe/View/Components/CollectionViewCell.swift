//
//  CollectionViewCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private var firstSticker: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private var secondSticker: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var firstRow: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [firstSticker, secondSticker])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 80
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var thirdSticker: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private var fourthSticker: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var secondRow: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [thirdSticker, fourthSticker])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 80
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [firstRow, secondRow, spacer])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 60
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentStackView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentStackView.frame = contentView.bounds

        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            contentStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),

            firstSticker.heightAnchor.constraint(equalToConstant: 130),
            firstSticker.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.3),
            secondSticker.heightAnchor.constraint(equalToConstant: 130),
            secondSticker.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.3),
            thirdSticker.heightAnchor.constraint(equalToConstant: 130),
            thirdSticker.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.3),
            fourthSticker.heightAnchor.constraint(equalToConstant: 130),
            fourthSticker.widthAnchor.constraint(equalTo: contentStackView.widthAnchor, multiplier: 0.3)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.firstSticker.image = nil
        self.secondSticker.image = nil
        self.thirdSticker.image = nil
        self.fourthSticker.image = nil
    }
    
    func setImage(image: UIImage?) {
        self.firstSticker.image = image
        self.secondSticker.image = image
        self.thirdSticker.image = image
        self.fourthSticker.image = image
    }
}
