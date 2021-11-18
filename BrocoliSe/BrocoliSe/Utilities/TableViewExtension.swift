//
//  TableViewExtension.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 17/11/21.
//

import Foundation
import UIKit

extension UITableView {
    func setEmptyView(for type: EmptyViewType) {
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
        messageLabel.font = self.bounds.size.height > 400 ? .graviolaRegular(size: 17) : .graviolaRegular(size: 14)

        switch type {
        case .apiRecipes:
            messageLabel.text = "Parece que ocorreu um erro ao carregar os dados."
        case .savedRecipes:
            messageLabel.attributedText = fullString
        }

        let brocolisImage = UIImageView(image: UIImage(named: "brocolis-triste"))
        brocolisImage.translatesAutoresizingMaskIntoConstraints = false
        brocolisImage.contentMode = .scaleAspectFit
        brocolisImage.alpha = 0.7

        emptyView.addSubview(messageLabel)
        emptyView.addSubview(brocolisImage)

        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: emptyView.topAnchor),
            messageLabel.trailingAnchor.constraint(equalTo: emptyView.trailingAnchor, constant: -40),
            messageLabel.leadingAnchor.constraint(equalTo: emptyView.leadingAnchor, constant: 40),

            brocolisImage.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 30),
            brocolisImage.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            brocolisImage.heightAnchor.constraint(equalTo: emptyView.heightAnchor,
                                                  multiplier: self.bounds.size.height > 400 ? 0.3 : 0.4)
        ])

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .none
    }
}
