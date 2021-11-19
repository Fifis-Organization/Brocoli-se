//
//  StepsCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

class StepsCell: UITableViewCell {

    static let identifier = String(describing: StepsCell.self)
    
    private var stepsLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.graviolaRegular(size: 17)
        label.textColor = .blueDark
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var stepsNumberLabel: UILabel = {
        var label = UILabel()
        label.font = UIFont.graviolaSoft(size: 22)
        label.textColor = .blueDark
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupIngredientDescription()
    }
    
    private func setupIngredientDescription() {
        addSubview(stepsNumberLabel)
        addSubview(stepsLabel)
        
        NSLayoutConstraint.activate([
            stepsNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            stepsNumberLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            stepsNumberLabel.widthAnchor.constraint(equalToConstant: 25),
            stepsNumberLabel.heightAnchor.constraint(equalToConstant: 25),
            
            stepsLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 12),
            stepsLabel.leftAnchor.constraint(equalTo: stepsNumberLabel.rightAnchor, constant: 10),
            stepsLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30),
            stepsLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    func setStep(number: Int, text: String) {
        stepsNumberLabel.text = "\(number)"
        stepsLabel.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
