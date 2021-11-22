//
//  TableViewExtension.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 17/11/21.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyView(for type: EmptyViewType,
                      tapButton: UITapGestureRecognizer? = nil) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let imageAttachment = NSTextAttachment()
        guard let color: UIColor = .blueDark?.withAlphaComponent(0.7) else { return }
        imageAttachment.image = UIImage(systemName: "bookmark.circle.fill")?.withTintColor(color)

        let fullString = NSMutableAttributedString(string: "Parece que você ainda não salvou nenhuma receita.\nAbra uma receita e clique em ")
        fullString.append(NSAttributedString(attachment: imageAttachment))
        fullString.append(NSAttributedString(string: " para salvar."))

        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.textColor = color
        messageLabel.font = .graviolaRegular(size: 17)
       
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Recarregar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .graviolaRegular(size: 16)
        button.backgroundColor = .greenMedium
        button.layer.cornerRadius = 8
        if let tapButton = tapButton {
            button.addGestureRecognizer(tapButton)
        }
        
        let brocolisImage = UIImageView(image: UIImage(named: "brocolis-triste"))
        brocolisImage.translatesAutoresizingMaskIntoConstraints = false
        brocolisImage.contentMode = .scaleAspectFit
        brocolisImage.alpha = 0.7
       
        switch type {
        case .apiRecipes:
            messageLabel.text = "Parece que ocorreu um erro ao carregar os dados."
            button.isHidden = false
            brocolisImage.isHidden = false
        case .savedRecipes:
            messageLabel.attributedText = fullString
            button.isHidden = true
            brocolisImage.isHidden = true
        case .emptySearch:
            messageLabel.text = "Sua pesquisa não corresponde a nenhuma receita."
            button.isHidden = true
            brocolisImage.isHidden = true
        }

        emptyView.addSubview(messageLabel)
        emptyView.addSubview(brocolisImage)
        emptyView.addSubview(button)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: emptyView.topAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40),

            brocolisImage.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            brocolisImage.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            brocolisImage.heightAnchor.constraint(equalTo: emptyView.heightAnchor, multiplier: 0.3),
            
            button.topAnchor.constraint(equalTo: brocolisImage.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            button.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            button.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40)
        ])

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
