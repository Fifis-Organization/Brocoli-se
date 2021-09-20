//
//  Onboarding03.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class Onboarding03: UIView {
    
    weak var onboardingVC: OnboardingViewController?
    
    
    
    let buttonConfirm: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.font = UIFont(name: "graviola-regular", size: 17)
        button.backgroundColor = .greenMedium
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(targetContiue), for: .touchUpInside)
        return button
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "brocolis-happy"))
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let welcomeText: UILabel = {
        let title = UILabel()
        title.text = "Quais alimentos você não está consumindo?"
        title.font = UIFont(name: "graviola-regular", size: 17)
        title.textColor = .blueDark
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    let foodSelector = FoodSelectorComponent(frame: UIScreen.main.bounds)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true 
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func targetContiue(_ sender: UIButton) {
        buttonContinueAction()
    }
    
    func style() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        
        foodSelector.translatesAutoresizingMaskIntoConstraints = false
        
        buttonConfirm.translatesAutoresizingMaskIntoConstraints = false
        
    }
        
    func layout() {
        addSubview(imageView)
        addSubview(welcomeText)
        addSubview(foodSelector)
        addSubview(buttonConfirm)
        
      
        NSLayoutConstraint.activate([
            
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            welcomeText.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 4),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: welcomeText.trailingAnchor, multiplier: 4),
            welcomeText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            welcomeText.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            foodSelector.widthAnchor.constraint(equalToConstant: 280),
            foodSelector.heightAnchor.constraint(equalToConstant: 66),
            foodSelector.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 10),
            foodSelector.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonConfirm.widthAnchor.constraint(equalToConstant: 144),
            buttonConfirm.heightAnchor.constraint(equalToConstant: 36),
            buttonConfirm.topAnchor.constraint(equalTo: foodSelector.bottomAnchor, constant: 20),
            buttonConfirm.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

}

extension Onboarding03: OnboardingViewControllerProtocol {
    func buttonContinueAction() {
        guard let onboardingVC = onboardingVC,
              let didSendContinue = onboardingVC.didSendContinue else {return}
        didSendContinue()
    }
    
    
}

