//
//  SearchBar.swift
//  BrocoliSe
//
//  Created by Larissa Uchoa on 11/11/21.
//

import UIKit

class SearchBar: UISearchBar {

    var clearButtonImage: UIImage?
    var clearButtonColor: UIColor = .white

    override func layoutSubviews() {
        super.layoutSubviews()

        if let textField = self.value(forKey: "searchField") as? UITextField {
            if let clearButton = textField.value(forKey: "clearButton") as? UIButton {
                update(button: clearButton, image: self.clearButtonImage, color: clearButtonColor)
            }
        }
        setupTextFieldColors()
    }

    private func update(button: UIButton, image: UIImage?, color: UIColor) {
        let image = (image ?? button.currentImage)?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.setImage(image, for: .highlighted)
        button.tintColor = color
    }

    private func setupTextFieldColors() {
        self.searchTextField.tintColor = .greenMedium
        self.searchTextField.backgroundColor = .backgroundColor
        self.searchTextField.textColor = .greenMedium
        self.searchTextField.tokenBackgroundColor = .greenMedium
        self.searchTextField.font = .graviolaRegular(size: 17)
        self.searchTextField.leftView?.tintColor = .greenMedium
    }
}
