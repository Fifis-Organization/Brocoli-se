//
//  ProfileSelectionCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 14/10/21.
//

import UIKit

struct ProfileModel {
    var name: String
    var icon: Data?
}

class ProfileSelectionCell: UITableViewCell {
    
    private var backgroundButton: UIView = {
        let view = UIView()
        view.backgroundColor = .backgroundColor
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 8
        view.clipsToBounds = true
        return view
    }()
    
    static let identifier = String(describing: ProfileSelectionCell.self)
    
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.accessibilityIgnoresInvertColors = true
        imageView.image = UIImage(systemName: "person.crop.circle.fill")
        imageView.tintColor = .blueDark
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.graviolaRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.text = "Informações pessoais"
        label.textColor = .blueDark?.withAlphaComponent(0.8)
        label.font = UIFont.graviolaRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var customNextButton = CustomViewButton()
    
    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, infoLabel])
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(profileImageView)
        addSubview(labelStackView)
        addSubview(customNextButton)
        setupImageView()
        setupCustomNextButton()
        setupLabelStackView()
    }
    
    private func setupImageView() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func setupLabelStackView() {
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelStackView.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 20),
            labelStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            labelStackView.rightAnchor.constraint(equalTo: customNextButton.leftAnchor)
        ])
    }
    
    private func setupCustomNextButton() {
        customNextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            customNextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            customNextButton.widthAnchor.constraint(equalTo: customNextButton.heightAnchor),
            customNextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupProfile(model: ProfileModel) {
        self.nameLabel.text = model.name
        if let icon = model.icon {
            self.profileImageView.image = UIImage(data: icon)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
