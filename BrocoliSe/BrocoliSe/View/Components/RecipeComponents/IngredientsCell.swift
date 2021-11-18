//
//  IngredientsCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

class IngredientsCell: UITableViewCell {

    static let identifier = String(describing: IngredientsCell.self)
    
    private var ingredientLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.graviolaRegular(size: 17)
        label.textColor = .blueDark
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var pointSymbol: UIImageView = {
        var imageView = UIImageView()
        imageView.image = UIImage(systemName: "circle.fill")
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .blueDark
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIngredientDescription()
    }
    
    private func setupIngredientDescription() {
        addSubview(pointSymbol)
        addSubview(ingredientLabel)
        
        NSLayoutConstraint.activate([
            pointSymbol.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            pointSymbol.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            pointSymbol.widthAnchor.constraint(equalToConstant: 10),
            pointSymbol.heightAnchor.constraint(equalToConstant: 10),
            
            ingredientLabel.leftAnchor.constraint(equalTo: pointSymbol.rightAnchor, constant: 15),
            ingredientLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            ingredientLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            ingredientLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20)
        ])
    }
    
    func setIngredientsLabel(text: String) {
        ingredientLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
