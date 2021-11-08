//
//  TextField.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class TextField: UIView {
    
    private let nameTextField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .backgroundColor
        self.layer.cornerRadius = 22
        self.layer.shadowColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOpacity = 0.04
        styleTextField(nameTextField, withText: "Nome")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleTextField(_ textField: UITextField, withText text: String) {
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .clear
        textField.placeholder = text
        textField.tintColor = UIColor.blueDark
        textField.font = UIFont.init(name: "graviola-regular", size: 17)
        textField.textColor = UIColor.blueDark
        textField.adjustsFontSizeToFitWidth = true
        addSubview(nameTextField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            textField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            textField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func getnameTextField() -> String {
        return nameTextField.text ?? ""
    }

    func setPlaceHolder(userName: String) {
        self.nameTextField.placeholder = userName
    }
}

extension TextField: UITextFieldDelegate {
    
    func myKeyBoard () {
        nameTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return nameTextField.resignFirstResponder()
    }
    
    func dismissKeyborad() {
        nameTextField.resignFirstResponder()
    }
}
