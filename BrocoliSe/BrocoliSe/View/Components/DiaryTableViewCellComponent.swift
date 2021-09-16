//
//  DiaryTableViewCellComponent.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 15/09/21.
//

import UIKit

class DiaryTableViewCellComponent: UITableViewCell {

    var checkButtonCallBack: () -> Void  = { }

    private var isChecked: Bool = false

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.isUserInteractionEnabled = true
        self.backgroundColor = .clear

        configureCheckButton()
        configureContainerView()
        configureiconImageView()
        configureFoodLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }

    lazy var checkButton: UIButton = {
        let button = UIButton()

        button.setImage(UIImage(systemName: "circle"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill

        button.tintColor = .greenMedium
        button.addTarget(self, action: #selector(didCheck), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.backgroundColor
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.06
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let iconImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "leite-icon")?.withRenderingMode(.alwaysTemplate)
        image.tintColor = .blueDark
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let foodLabel: UILabel = {
        let label = UILabel()
        label.font = .graviolaRegular(size: 18)
        label.text = "Laticinios"
        label.textColor = .blueDark
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    @objc func didCheck() {
        self.isChecked.toggle()
        checkButton.setImage(UIImage(systemName: isChecked ? "checkmark.circle.fill":"circle"), for: .normal)
        checkButtonCallBack()
    }

    func setData(iconName: String, foodName: String) {
        iconImageView.image = UIImage(named: iconName)?.withRenderingMode(.alwaysTemplate)
        foodLabel.text = foodName
    }

    // MARK: Create method to get name and state to save it on the viewController
    func getData() {}

    private func configureCheckButton() {
        self.contentView.addSubview(checkButton)

        NSLayoutConstraint.activate([
            checkButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            checkButton.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.48),
            checkButton.widthAnchor.constraint(equalTo: self.checkButton.heightAnchor),
            checkButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])
    }

    private func configureContainerView() {
        self.contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
            containerView.leadingAnchor.constraint(equalTo: self.checkButton.trailingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    private func configureiconImageView() {
        self.containerView.addSubview(iconImageView)

        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalTo: self.containerView.heightAnchor, multiplier: 0.48),
            iconImageView.widthAnchor.constraint(equalTo: self.iconImageView.heightAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor, constant: 25)
        ])
    }

    private func configureFoodLabel() {
        self.containerView.addSubview(foodLabel)

        NSLayoutConstraint.activate([
            foodLabel.centerYAnchor.constraint(equalTo: self.containerView.centerYAnchor),
            foodLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 20)
        ])
    }
    
}
