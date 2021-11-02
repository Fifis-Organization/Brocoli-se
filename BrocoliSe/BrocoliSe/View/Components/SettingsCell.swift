//
//  AjustesCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 21/10/21.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    static let identifier = String(describing: SettingsCell.self)
    
    var didSwitchButton: ((_ value: Bool) -> Void)?
    
    private var customNextButton = CustomViewButton()
    
    private var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.tintColor = .blueDark?.withAlphaComponent(0.2)
        return imageView
    }()
    
    private var settingsLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blueDark
        label.font = UIFont.graviolaRegular(size: 16) ?? UIFont.systemFont(ofSize: 16)
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "OFF"
        label.textAlignment = .right
        label.textColor = .blueSoft
        label.font = UIFont.graviolaRegular(size: 14) ?? UIFont.systemFont(ofSize: 14)
        return label
    }()

    private var slider: UISwitch = {
        let switchSlider = UISwitch()
        switchSlider.onTintColor = .greenMedium
        switchSlider.isEnabled = true
        switchSlider.addTarget(self, action: #selector(switchChanged), for: UIControl.Event.valueChanged)
        return switchSlider
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    @objc func switchChanged() {
        if slider.isOn {
            statusLabel.text = "ON"
            self.didSwitchButton?(true)
        } else {
            statusLabel.text = "OFF"
            self.didSwitchButton?(false)
        }
    }
    
    func setupView() {
        contentView.addSubview(iconImageView)
        contentView.addSubview(slider)
        contentView.addSubview(statusLabel)
        contentView.addSubview(settingsLabel)
        setupIconImageView()
        setupSlider()
        setupStatusLabel()
        setupSettingsLabel()
    }
    
    func setupIconImageView() {
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupSettingsLabel() {
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 20),
            settingsLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            settingsLabel.rightAnchor.constraint(equalTo: statusLabel.leftAnchor, constant: -20)
        ])
    }
    
    func setupStatusLabel() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            statusLabel.widthAnchor.constraint(equalToConstant: 40),
            statusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            statusLabel.rightAnchor.constraint(equalTo: slider.leftAnchor, constant: -10)
        ])
    }
    
    func setupSlider() {
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            slider.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    func setupCustomNextButton() {
        customNextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customNextButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            customNextButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4),
            customNextButton.widthAnchor.constraint(equalTo: customNextButton.heightAnchor),
            customNextButton.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setIconImageView(imageName: String) {
        self.iconImageView.image = UIImage(systemName: imageName) ?? UIImage(named: imageName)
        checkInstagramCell()
    }
    
    func setSettingsLabel(text: String) {
        self.settingsLabel.text = text
    }
    
    func initSwitchStatus(value: Bool) {
        self.slider.isOn = value
        self.statusLabel.text = value ? "ON" : "OFF"
    }
    
    func checkInstagramCell() {
        if self.settingsLabel.text == "Brocoli-se no Instagram" {
            statusLabel.isHidden = true
            slider.isHidden = true
            contentView.addSubview(customNextButton)
            setupCustomNextButton()
        }
    }

}
