//
//  InfoRecipeCell.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 17/11/21.
//

import UIKit

class InforRecipeCell: UITableViewCell {

    static let identifier = String(describing: InforRecipeCell.self)
    
    private var infoCardComponentTimer = InfoCardComponent()
    private var infoCardComponentPorcoes = InfoCardComponent()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupInfoCardTimer()
        setupInfoCardPorcoes()
    }
    
    private func setupInfoCardTimer() {
        self.addSubview(infoCardComponentTimer)
        
        infoCardComponentTimer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoCardComponentTimer.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            infoCardComponentTimer.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            infoCardComponentTimer.widthAnchor.constraint(equalToConstant: 85),
            infoCardComponentTimer.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        infoCardComponentTimer.layer.cornerRadius = 8
    }
    
    private func setupInfoCardPorcoes() {
        self.addSubview(infoCardComponentPorcoes)
        
        infoCardComponentPorcoes.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            infoCardComponentPorcoes.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            infoCardComponentPorcoes.leftAnchor.constraint(equalTo: infoCardComponentTimer.rightAnchor, constant: 20),
            infoCardComponentPorcoes.widthAnchor.constraint(equalToConstant: 85),
            infoCardComponentPorcoes.heightAnchor.constraint(equalToConstant: 85)
        ])
        
        infoCardComponentPorcoes.layer.cornerRadius = 8
    }
    
    func setCardInfo(timerText:String, porcoesText: String) {
        infoCardComponentPorcoes.switchCardType(.porcoes, labelText: porcoesText)
        infoCardComponentTimer.switchCardType(.timer, labelText: timerText)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
