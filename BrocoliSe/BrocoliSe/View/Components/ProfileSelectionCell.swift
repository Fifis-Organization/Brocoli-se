//
//  ProfileSelectionCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 14/10/21.
//

import UIKit

class ProfileSelectionCell: UITableViewCell {
    private var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Informações pessoais"
        label.textColor = .black
        label.font = UIFont.graviolaRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blueDark
        label.font = UIFont.graviolaRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
