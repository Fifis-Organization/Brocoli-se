//
//  InfoCardComponent.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

enum CardType {
    case timer
    case porcoes
}

class InfoCardComponent: UIView {
    
    private var imageView: UIImageView = {
        var imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private var label: UILabel = {
        var label = UILabel()
        label.font = UIFont.graviolaSoft(size: 12)
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupImageView()
        self.setupLabel()
    }
    
    private func setupImageView() {
        self.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 28),
            imageView.widthAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func setupLabel() {
        self.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func switchCardType(_ type: CardType, labelText: String) {
        switch type {
        case .timer:
            imageView.image = UIImage(named: "timer-icon")?.withRenderingMode(.alwaysTemplate)
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = .strongBlue
            label.textColor = .strongBlue
            label.text = labelText
            self.backgroundColor = .lightBlue
        case .porcoes:
            imageView.image = UIImage(named: "quantidade-icon")?.withRenderingMode(.alwaysTemplate)
            imageView.contentMode = .scaleAspectFill
            imageView.tintColor = .strongBrown
            label.textColor = .strongBrown
            label.text = labelText
            self.backgroundColor = .lightBrown
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
