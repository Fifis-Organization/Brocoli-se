//
//  Components.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 08/09/21.
//

import UIKit
import UBProgress

class ProgressBarComponent: UIView {

    var progressValue = 0.8
    
    let progressBar = UBProgress()
    
    let circle: UIView = {
        let circle = UIView()
        circle.backgroundColor = UIColor.backgroundColor
        circle.layer.cornerRadius = 16
        return circle
    }()
    
    let image: UIImageView = {
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
        addCircle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProgress() {
        
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(progressBar)
        NSLayoutConstraint.activate([
            progressBar.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progressBar.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: 20),
            progressBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8)
        ])
        
        progressBar.setProgress(CGFloat(progressValue), animated: true)
        progressBar.progress = 0.8
        progressBar.setTypeText(.fixedCenter)
        progressBar.setTypeForm(.inLine)
        progressBar.setFont(UIFont.graviolaRegular(size: 10) ?? UIFont.systemFont(ofSize: 30))
        progressBar.setLabelTextColor(.blueDark!)
        progressBar.progressTintColor = UIColor.greenSoft!
        progressBar.backgroundTintColor = UIColor.backgroundColor!
        progressBar.cornerRadius = 10
        
    }
    
    
    func addCircle() {
        circle.translatesAutoresizingMaskIntoConstraints = false
        addSubview(circle)
        
            NSLayoutConstraint.activate([
                circle.centerYAnchor.constraint(equalTo: progressBar.centerYAnchor),
                circle.centerXAnchor.constraint(equalTo: progressBar.trailingAnchor),
                circle.heightAnchor.constraint(equalToConstant: 30),
                circle.widthAnchor.constraint(equalToConstant: 30)
            ])
        
        if progressValue == 1.0 {
            circle.backgroundColor = UIColor.greenSoft
        }
        
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)

            NSLayoutConstraint.activate([
                image.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
                image.centerXAnchor.constraint(equalTo: circle.centerXAnchor),
                image.heightAnchor.constraint(equalToConstant: 18),
                image.widthAnchor.constraint(equalToConstant: 18)
            ])
    }

}
