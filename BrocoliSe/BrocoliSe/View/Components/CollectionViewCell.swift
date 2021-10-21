//
//  CollectionViewCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 20/09/21.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    static let identifier = "CollectionViewCell"
    
    private var firstStickerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var labelFirstSticker: UILabel = {
        let label = UILabel()
        label.text = "                    "
        label.font = self.frame.height > 667 ? .graviolaRegular(size: 16) : .graviolaRegular(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var firstSticker: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [firstStickerImage, labelFirstSticker])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.frame.height > 667 ? 20 : 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var secondStickerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var labelSecondSticker: UILabel = {
        let label = UILabel()
        label.text = "                    "
        label.font = self.frame.height > 667 ? .graviolaRegular(size: 16) : .graviolaRegular(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var secondSticker: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [secondStickerImage, labelSecondSticker])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.frame.height > 667 ? 20 : 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var firstRow: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [firstSticker, secondSticker])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 60
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var thirdStickerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var labelThirdSticker: UILabel = {
        let label = UILabel()
        label.text = "                    "
        label.font = self.frame.height > 667 ? .graviolaRegular(size: 16) : .graviolaRegular(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var thirdSticker: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [thirdStickerImage, labelThirdSticker])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.frame.height > 667 ? 20 : 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var fourthStickerImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var labelFourthSticker: UILabel = {
        let label = UILabel()
        label.text = "                    "
        label.font = self.frame.height > 667 ? .graviolaRegular(size: 16) : .graviolaRegular(size: 14)
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var fourthSticker: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [fourthStickerImage, labelFourthSticker])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.frame.height > 667 ? 20 : 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var secondRow: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [thirdSticker, fourthSticker])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 60
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var contentStackView: UIStackView = {
        let spacer = UIView()
        let stackView = UIStackView(arrangedSubviews: [firstRow, secondRow, spacer])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = self.frame.height > 667 ? 80 : 40
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

            firstSticker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.24),
            firstSticker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.314),
            secondSticker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.24),
            secondSticker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.314),
            thirdSticker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.24),
            thirdSticker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.314),
            fourthSticker.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.24),
            fourthSticker.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.314)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.firstStickerImage.image = nil
        self.secondStickerImage.image = nil
        self.thirdStickerImage.image = nil
        self.fourthStickerImage.image = nil
    }
    
    func setStickers(stickers: [String]) {
        self.firstStickerImage.image = setSticker(stickers: stickers, index: 0)
        self.labelFirstSticker.text = setLabel(stickers: stickers, index: 0)

        self.secondStickerImage.image = setSticker(stickers: stickers, index: 1)
        self.labelSecondSticker.text = setLabel(stickers: stickers, index: 1)

        self.thirdStickerImage.image = setSticker(stickers: stickers, index: 2)
        self.labelThirdSticker.text = setLabel(stickers: stickers, index: 2)

        self.fourthStickerImage.image = setSticker(stickers: stickers, index: 3)
        self.labelFourthSticker.text = setLabel(stickers: stickers, index: 3)
    }

    private func setSticker(stickers: [String], index: Int) -> UIImage {
        if stickers.indices.contains(index) {
            return UIImage(named: stickers[index]) ?? UIImage()
        } else {
            return UIImage()
        }
    }

    private func setLabel(stickers: [String], index: Int) -> String {
        if stickers.indices.contains(index) {
            if stickers[index].localizedStandardContains("sticker") {
                return "\(stickerDays(sticker: stickers[index])) dias concluídos"
            }
        }
        return "                    "
    }

    private func stickerDays(sticker: String) -> Int {
        switch sticker {
        case StickersNames.esquiloSticker:
            return 10
        case StickersNames.patinhoSticker:
            return 20
        case StickersNames.pintinhoSticker:
            return 30
        case StickersNames.vaquinhaSticker:
            return 40
        case StickersNames.jacarezinhoSticker:
            return 50
        case StickersNames.ovelhinhaSticker:
            return 60
        case StickersNames.porquinhoSticker:
            return 70
        case StickersNames.sapinhoSticker:
            return 80
        case StickersNames.zebrinhaSticker:
            return 90
        default:
            return 0
        }
    }
}
