//
//  Onboarding01.swift
//  BrocoliSe
//
//  Created by Paulo Uchôa on 20/09/21.
//

import UIKit

class Onboarding01: UIView {
    
    let imageView: UIImageView = {
        let image = UIImageView(image: UIImage(named: "brocolis-receptivo"))
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    let welcomeText: UILabel = {
        let title = UILabel()
        title.text = "Olá! Muito bom ver você aqui, irei te acompanhar na sua grande jornada!"
        title.font = UIFont(name: "graviola-regular", size: 17)
        title.textColor = .blueDark
        title.textAlignment = .center
        title.numberOfLines = 0
        return title
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        style()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func style() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        welcomeText.translatesAutoresizingMaskIntoConstraints = false
        
    }
        
    func layout() {
        addSubview(imageView)
        addSubview(welcomeText)
        
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0),
            
            welcomeText.leadingAnchor.constraint(equalToSystemSpacingAfter: self.leadingAnchor, multiplier: 4),
            self.trailingAnchor.constraint(equalToSystemSpacingAfter: welcomeText.trailingAnchor, multiplier: 4),
            welcomeText.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            welcomeText.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0)
        ])
    }

}
