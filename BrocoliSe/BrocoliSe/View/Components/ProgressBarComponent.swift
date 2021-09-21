//
//  Components.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit
import UBProgress

class ProgressBarComponent: UIView {
    
    var progressValue: Float = 0.90
    
    private let progressBar = UBProgress()
    
    private let circle: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.backgroundColor
        circle.layer.cornerRadius = 16
        return circle
    }()
    
    private let progressText: UILabel = {
        let text = UILabel()
        text.font = UIFont.graviolaRegular(size: 13) ?? UIFont.systemFont(ofSize: 30)
        text.text = "Text test"
        text.tintColor = .blueDark
        return text
    }()
    
    private let image: UIImageView = {
        let image = UIImageView(image: UIImage(systemName: "gift.fill"))
        image.clipsToBounds = true
        image.backgroundColor = UIColor.clear
        image.tintColor = UIColor.blueDark
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addProgress()
        addProgressText()
        addCircle()
        progressTextSetup(progressValue: progressValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addProgress() {
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 22),
            progressBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -18),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        progressBar.setProgress(CGFloat(progressValue), animated: true)
        progressBar.progress = CGFloat(progressValue)
        progressBar.setTypeText(.none)
        progressBar.setTypeForm(.inLine)
        progressBar.setFont(UIFont.graviolaRegular(size: 10) ?? UIFont.systemFont(ofSize: 30))
        progressBar.setLabelTextColor((.blueDark ?? .black))
        progressBar.progressTintColor = UIColor.greenSoft ?? UIColor.gray
        progressBar.backgroundTintColor = UIColor.backgroundColor ?? UIColor.white
        progressBar.cornerRadius = 10
    }
    
    private  func addProgressText() {
        progressText.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressText)
        NSLayoutConstraint.activate([
            progressText.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            progressText.centerXAnchor.constraint(equalTo: progressBar.centerXAnchor)
        ])
        
    }
    
    private func progressTextSetup(progressValue: Float) {
        
        if progressValue == 1 {
            progressText.text = "Ciclo Completo"
        } else {
            progressText.text = "\(Int(((1.0 - progressValue)*10).rounded(.toNearestOrEven))) dias restantes"
        }
        
    }
    private  func addCircle() {
        circle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circle)
        
        NSLayoutConstraint.activate([
            circle.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
            circle.centerXAnchor.constraint(equalTo: progressBar.trailingAnchor),
            circle.heightAnchor.constraint(equalToConstant: 35),
            circle.widthAnchor.constraint(equalToConstant: 35)
        ])
        
        if progressValue == 1.0 {
            circle.backgroundColor = UIColor.greenSoft
        }
        
        image.translatesAutoresizingMaskIntoConstraints = false
        circle.addSubview(image)
        
        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
            image.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
            image.heightAnchor.constraint(equalToConstant: 24),
            image.widthAnchor.constraint(equalToConstant: 24)
        ])
    }
}
