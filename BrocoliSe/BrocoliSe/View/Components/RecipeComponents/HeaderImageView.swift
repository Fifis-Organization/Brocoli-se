//
//  HeaderImageView.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

class HeaderImageView: UIView {
    
    private let maskImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "maskImage"))
        return image
    }()

    private let imageHeader: UIImageView = {
        let image = UIImageView(image: UIImage(named: "emptyStateFoto"))
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configImageHeader()
        configMaskFoto()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configImageHeader() {
        self.addSubview(imageHeader)
        imageHeader.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageHeader.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageHeader.topAnchor.constraint(equalTo: self.topAnchor),
            imageHeader.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0),
            imageHeader.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0)
        ])
    }
    
    func setImageHeader(urlString: String) {
        if let baseUrl = URL(string: urlString) {
            self.imageHeader.kf.setImage(with: baseUrl)
        } else {
            self.imageHeader.image = UIImage(named: "fotoReceita-EmptyState")
        }
        self.imageHeader.image?.withRenderingMode(.alwaysOriginal)
    }
    
    private func configMaskFoto() {
        self.addSubview(maskImage)
        maskImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            maskImage.topAnchor.constraint(equalTo: self.topAnchor),
            maskImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            maskImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.0),
            maskImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.0)
        ])
    }
}
