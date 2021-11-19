//
//  RecipeListCell.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 09/11/21.
//

import UIKit
import Kingfisher

class RecipeListCell: UITableViewCell {

    static let identifier = String(describing: RecipeListCell.self)

    var didTapCell: () -> Void  = { }

    // MARK: - UI

    private lazy var recipeImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "foto-perfil")
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = false
        image.layer.cornerRadius = 8
        image.clipsToBounds = true
        return image
    }()

    private let recipeName: UILabel = {
        let label = UILabel()
        label.font = .graviolaRegular(size: 16)
        label.textColor = .blueDark
        label.numberOfLines = 0
        label.text = "Hambúrguer de carne de jaca"
        return label
    }()

    private lazy var recipeTime: LabelWithLeftImage = {
        let image = UIImage(named: "relogio-icon") ?? UIImage()
        let time = LabelWithLeftImage(frame: .zero, image: image)
        time.setLabelText(text: "30 minutos")
        return time
    }()

    private lazy var recipePortions: LabelWithLeftImage = {
        let image = UIImage(named: "porcoes-icon") ?? UIImage()
        let time = LabelWithLeftImage(frame: .zero, image: image)
        time.setLabelText(text: "3 porções")
        return time
    }()

    private lazy var textStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [recipeTime,
                                                       recipePortions])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.07
        view.layer.shadowOffset = CGSize(width: 2, height: 2)
        view.layer.shadowRadius = 4.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - INIT

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureTapGesture()
        createViewHierarchy()
        backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func showRecipe() {
        didTapCell()
    }

    // MARK: - PUBLIC METHODS

    func configureCell(model: RecipeModel) {
        if let baseUrl = URL(string: model.pathPhoto) {
            self.recipeImage.kf.setImage(with: baseUrl)
        } else {
            self.recipeImage.image = UIImage(named: "fotoReceita-EmptyState")
        }
        
        self.recipeName.text = model.name
        self.recipeTime.setLabelText(text: model.time)
        self.recipePortions.setLabelText(text: model.portions)
    }

    // MARK: - PRIVATE METHODS

    private func createViewHierarchy() {
        configureContainerView()
        configureImageConstraints()
        configureRecipeName()
        configureTextStack()
    }

    private func configureTapGesture() {
        self.containerView.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showRecipe))
        self.containerView.addGestureRecognizer(tapRecognizer)
    }

    private func configureContainerView() {
        self.contentView.addSubview(containerView)

        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalTo: self.heightAnchor, constant: -20),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -30)
        ])
    }

    private func configureImageConstraints() {
        containerView.addSubview(recipeImage)
        recipeImage.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recipeImage.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            recipeImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            recipeImage.topAnchor.constraint(equalTo: containerView.topAnchor),
            recipeImage.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.365)
        ])
    }

    private func configureRecipeName() {
        containerView.addSubview(recipeName)
        recipeName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            recipeName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            recipeName.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 15),
            recipeName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }

    private func configureTextStack() {
        containerView.addSubview(textStack)

        NSLayoutConstraint.activate([
            textStack.leadingAnchor.constraint(equalTo: recipeImage.trailingAnchor, constant: 15),
            textStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),
            textStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
        ])
    }
}
