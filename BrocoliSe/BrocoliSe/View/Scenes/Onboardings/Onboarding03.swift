//
//  Onboarding03.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class Onboarding03: UIView {
    
    weak var onboardingVC: OnboardingViewController?
    
    private let buttonConfirm: UIButton = {
        let button = UIButton()
        button.setTitle("Continuar", for: .normal)
        button.titleLabel?.font = UIFont(name: "graviola-regular", size: 17)
        button.backgroundColor = .greenMedium
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(targetContiue), for: .touchUpInside)
        return button
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "brocolis-happy"))
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let welcomeText: UILabel = {
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
        guard let onboarding2 = onboardingVC?.view1 as? Onboarding02 else {return}
        if foodSelector.getSelected().isEmpty && onboarding2.getTextFieldName().isEmpty {
            foodSelector.shakeEffect(horizontaly: 4)
            buttonConfirm.shakeEffect(horizontaly: 4)
            onboardingVC?.alertConfirm(message: "Você deve inserir um nome e escolher algum alimento!")
        } else if foodSelector.getSelected().isEmpty {
            foodSelector.shakeEffect(horizontaly: 4)
            buttonConfirm.shakeEffect(horizontaly: 4)
            onboardingVC?.alertConfirm(message: "Você deve escolher algum alimento!")
        } else if onboarding2.getTextFieldName().isEmpty {
            foodSelector.shakeEffect(horizontaly: 4)
            buttonConfirm.shakeEffect(horizontaly: 4)
            onboardingVC?.alertConfirm(message: "Você deve inserir um nome!")
        } else {
            buttonContinueAction()
            
        }
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
            
            foodSelector.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.74),
            foodSelector.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.098),
            foodSelector.topAnchor.constraint(equalTo: welcomeText.bottomAnchor, constant: 10),
            foodSelector.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            buttonConfirm.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.38),
            buttonConfirm.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.053),
            buttonConfirm.topAnchor.constraint(equalTo: foodSelector.bottomAnchor, constant: 20),
            buttonConfirm.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
}

extension Onboarding03: OnboardingViewControllerProtocol {
    func buttonContinueAction() {
        onboardingVC?.saveSelectedFood(selectedFood: foodSelector.getSelected())
        onboardingVC?.saveUser()
        guard let onboardingVC = onboardingVC,
              let didSendContinue = onboardingVC.didSendContinue else {return}
        let persistence = PersistenceService()
        persistence.persist(firstLoad: true)
        didSendContinue()
    }
    func disableContinueButton() {
        guard let onboarding2 = onboardingVC?.view1 as? Onboarding02 else {return}
        
        if foodSelector.getSelected().isEmpty || onboarding2.getTextFieldName().isEmpty {
            buttonConfirm.isEnabled = false
            buttonConfirm.backgroundColor = UIColor.blueDark?.withAlphaComponent(0.4)
        } else {
            buttonConfirm.isEnabled = true
            buttonConfirm.backgroundColor = .greenMedium
        }
    }
}
