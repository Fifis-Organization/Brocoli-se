//
//  FoodSelectorComponent.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class FoodSelectorComponent: UIView {

    let buttonFood01: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "carne-icon")
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    var bool01 = false
    
    let buttonFood02: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "ovo-icon")
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    var bool02 = false
    
    let buttonFood03: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "leite-icon")
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    var bool03 = false
    
    let buttonFood04: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "frango-icon")
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    var bool04 = false
    
    let buttonFood05: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "peixe-icon")
        let imageconfig = image?.withRenderingMode(.alwaysTemplate)
        button.setImage(imageconfig, for: .normal)
        button.tintColor = UIColor.blueDark?.withAlphaComponent(0.4)
        return button
    }()
    var bool05 = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .backgroundColor
        self.layer.cornerRadius = 22
        self.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.04
        buttonFood01Style()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func button01(_ sender: UIButton) {
        buttonFood01.tintColor = .greenMedium
    }
    
    @objc func button02(_ sender: UIButton) {
        buttonFood02.tintColor = .greenMedium
    }
    
    @objc func button03(_ sender: UIButton) {
        buttonFood03.tintColor = .greenMedium
    }
    
    @objc func button04(_ sender: UIButton) {
        buttonFood04.tintColor = .greenMedium
    }
    
    @objc func button05(_ sender: UIButton) {
        buttonFood05.tintColor = .greenMedium
    }

    func buttonFood01Style() {
        buttonFood03.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonFood03)
        NSLayoutConstraint.activate([
            buttonFood03.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonFood03.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            buttonFood03.heightAnchor.constraint(equalToConstant: 32),
            buttonFood03.widthAnchor.constraint(equalToConstant: 32)
        ])
        buttonFood03.addTarget(self, action: #selector(button03), for: .touchUpInside)
        
        buttonFood02.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonFood02)
        NSLayoutConstraint.activate([
            buttonFood02.trailingAnchor.constraint(equalTo: buttonFood03.leadingAnchor, constant: -22),
            buttonFood02.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonFood02.heightAnchor.constraint(equalToConstant: 33),
            buttonFood02.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        buttonFood02.addTarget(self, action: #selector(button02), for: .touchUpInside)
        
        buttonFood04.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonFood04)
        NSLayoutConstraint.activate([
            buttonFood04.leadingAnchor.constraint(equalTo: buttonFood03.trailingAnchor, constant: 22),
            buttonFood04.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonFood04.heightAnchor.constraint(equalToConstant: 32),
            buttonFood04.widthAnchor.constraint(equalToConstant: 32)
        ])
        
        buttonFood04.addTarget(self, action: #selector(button04), for: .touchUpInside)
        
        buttonFood01.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonFood01)
        NSLayoutConstraint.activate([
            buttonFood01.trailingAnchor.constraint(equalTo: buttonFood02.leadingAnchor, constant: -22),
            buttonFood01.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonFood01.heightAnchor.constraint(equalToConstant: 27),
            buttonFood01.widthAnchor.constraint(equalToConstant: 33)
        ])
        buttonFood01.addTarget(self, action: #selector(button01), for: .touchUpInside)
        
        buttonFood05.translatesAutoresizingMaskIntoConstraints = false
        addSubview(buttonFood05)
        NSLayoutConstraint.activate([
            buttonFood05.leadingAnchor.constraint(equalTo: buttonFood04.trailingAnchor, constant: 22),
            buttonFood05.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            buttonFood05.heightAnchor.constraint(equalToConstant: 32),
            buttonFood05.widthAnchor.constraint(equalToConstant: 32)
        ])
        buttonFood05.addTarget(self, action: #selector(button05), for: .touchUpInside)
    }
}
