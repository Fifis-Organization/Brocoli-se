//
//  AjustesCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

class SettingsCell: UITableViewCell {
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var settingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.graviolaRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blueSoft
        label.font = UIFont.graviolaRegular(size: 14) ?? UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()

    private var slider: UISwitch = {
        let switchSlider = UISwitch()
        switchSlider.onTintColor = .greenMedium
        return switchSlider
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIconImageView(imageName: String) {
        self.iconImageView.image = UIImage(systemName: imageName)
    }
    
    func setSettingsLabel(text: String) {
        self.settingsLabel.text = text
    }
}
