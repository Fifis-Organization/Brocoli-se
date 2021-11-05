//
//  Onboarding02.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class Onboarding02: UIView {
    
    private var isActiveKeyboard: Bool = false
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "brocolis-feliz"))
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let welcomeText: UILabel = {
        let title = UILabel()
        title.text = "Qual seu nome?"
        title.font = UIFont(name: "graviola-regular", size: 17)
        title.textColor = .blueDark
        title.textAlignment = .center
        title.numberOfLines = 0
        
        return title
    }()
    
    let nameTextField = TextField(frame: UIScreen.main.bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
        nameTextField.myKeyBoard()
        let tapDismiss = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide(notification:)))
        addGestureRecognizer(tapDismiss)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            frame.origin.y -= (self.isActiveKeyboard ? 0 : 80)
            isActiveKeyboard = true
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        frame.origin.y += (self.isActiveKeyboard ? 80 : 0)
        isActiveKeyboard = false
        nameTextField.dismissKeyborad()
    }
    
    private func style() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout() {
        addSubview(imageView)
        addSubview(welcomeText)
        addSubview(nameTextField)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            welcomeText.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 4),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: welcomeText.trailingAnchor, multiplier: 4),
            welcomeText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            welcomeText.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            nameTextField.widthAnchor.constraint(equalToConstant: 200),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            nameTextField.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 10),
            nameTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func getTextFieldName() -> String {
        return nameTextField.getnameTextField() 
    }
}
