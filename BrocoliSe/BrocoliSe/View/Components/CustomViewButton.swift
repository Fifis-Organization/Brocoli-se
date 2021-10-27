//
//  CustomViewButton.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 25/10/21.
//

import UIKit

class CustomViewButton: UIView {
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.compact.right")
        imageView.tintColor = .blueDark
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addSubview(imageView)
        setupImageView()
    }
    
    func setupView() {
        self.backgroundColor = .backgroundColor
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
//        self.layer.shadowOffset = CGSize(width: -1, height: 1)
//        self.layer.shadowColor = UIColor.black.cgColor
//        self.layer.shadowOpacity = 0.8

    }
    
    func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
