//
//  FoodSelectorComponent.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class FoodSelectorComponent: UIView {
    
    private var selectedFood:[String] = []
    
    private let buttonCarne: IconButtonComponent = {
        let button = IconButtonComponent(type: .custom)
        button.identifier = FoodNames.carne
        let image = UIImage(named: IconNames.carne)
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    
    private let buttonOvo: IconButtonComponent = {
        let button = IconButtonComponent(type: .custom)
        button.identifier = FoodNames.ovos
        let image = UIImage(named: IconNames.ovos)
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    
    private let buttonLeite: IconButtonComponent = {
        let button = IconButtonComponent(type: .custom)
        button.identifier = FoodNames.leite
        let image = UIImage(named: IconNames.leite)
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    
    private let buttonFrango: IconButtonComponent = {
        let button = IconButtonComponent(type: .custom)
        button.identifier = FoodNames.frango
        let image = UIImage(named: IconNames.frango)
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    
    private let buttonPeixe: IconButtonComponent = {
        let button = IconButtonComponent(type: .custom)
        button.identifier = FoodNames.peixe
        let image = UIImage(named: IconNames.peixe)
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .backgroundColor
        self.layer.cornerRadius = 22
        self.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.04
        buttonFoodStyle()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func selectFood(_ sender: IconButtonComponent) {
        sender.isSelected.toggle()
        if sender.isSelected {
            selectedFood.append(sender.identifier)
            sender.tintColor = .greenMedium
        } else {
            selectedFood.removeAll { $0 == sender.identifier }
            sender.tintColor = .blueDark?.withAlphaComponent(0.4)
        }
    }
    
    
    private func buttonFoodStyle() {
        buttonLeite.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonLeite)
        NSLayoutConstraint.activate([
            buttonLeite.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonLeite.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonLeite.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.48),
            buttonLeite.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11)
        ])
        buttonLeite.addTarget(self, action: #selector(selectFood), for: .touchUpInside)
        
        buttonOvo.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonOvo)
        NSLayoutConstraint.activate([
            buttonOvo.trailingAnchor.constraint(equalTo: buttonLeite.leadingAnchor, constant: -22),
            buttonOvo.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonOvo.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.45),
            buttonOvo.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11)
        ])
        
        buttonOvo.addTarget(self, action: #selector(selectFood), for: .touchUpInside)
        
        buttonFrango.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonFrango)
        NSLayoutConstraint.activate([
            buttonFrango.leadingAnchor.constraint(equalTo: buttonLeite.trailingAnchor, constant: 22),
            buttonFrango.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonFrango.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.48),
            buttonFrango.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11)
            
        ])
        
        buttonFrango.addTarget(self, action: #selector(selectFood), for: .touchUpInside)
        
        buttonCarne.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonCarne)
        NSLayoutConstraint.activate([
            buttonCarne.trailingAnchor.constraint(equalTo: buttonOvo.leadingAnchor, constant: -22),
            buttonCarne.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonCarne.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.48),
            buttonCarne.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11)
        ])
        buttonCarne.addTarget(self, action: #selector(selectFood), for: .touchUpInside)
        
        buttonPeixe.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonPeixe)
        NSLayoutConstraint.activate([
            buttonPeixe.leadingAnchor.constraint(equalTo: buttonFrango.trailingAnchor, constant: 22),
            buttonPeixe.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonPeixe.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.48),
            buttonPeixe.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.11)
        ])
        buttonPeixe.addTarget(self, action: #selector(selectFood), for: .touchUpInside)
    }
    
    func getSelected() -> [String] {
        return selectedFood
    }
}
