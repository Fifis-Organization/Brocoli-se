//
//  CustomSegmentedControl.swift
//  BrocoliSe
//
//  Created by Nathalia Cardoso on 16/11/21.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl {
    
    private var leading = NSLayoutConstraint()
    
    private let segmentIndicator: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = false
        view.layer.cornerRadius = 1
        
        return view
    }()
    
    private var color = UIColor.greenMedium
    
    init() {
        super.init(items: ["Todas", "Salvas"])
        self.translatesAutoresizingMaskIntoConstraints = false
        configure()
        self.addSubview(segmentIndicator)
        setUpSegmentedIndicatorConstraints()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func configure() {
        self.selectedSegmentTintColor = .clear
        
        self.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        self.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        let attrsSelected = [
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.font: UIFont.graviolaRegular(size: 17) ?? UIFont.systemFont(ofSize: 17)
        ]
        
        let attrsNormal = [
            NSAttributedString.Key.foregroundColor: UIColor.blueSoft,
            NSAttributedString.Key.font: UIFont.graviolaRegular(size: 17) ?? UIFont.systemFont(ofSize: 17)
        ]
        
        self.setTitleTextAttributes(attrsSelected as [NSAttributedString.Key : Any], for: UIControl.State.selected)
        self.setTitleTextAttributes(attrsNormal as [NSAttributedString.Key : Any], for: UIControl.State.normal)
        segmentIndicator.backgroundColor = color
    }
    
    private func setUpSegmentedIndicatorConstraints() {
        segmentIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            segmentIndicator.topAnchor.constraint(equalTo: self.bottomAnchor, constant: -2.5),
            segmentIndicator.heightAnchor.constraint(equalToConstant: 2.5),
            segmentIndicator.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        leading.isActive = false
        leading = segmentIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (100 * CGFloat(self.selectedSegmentIndex)) + 5)
        leading.isActive = true
    }
    
    func indexChanged(newIndex: Int) {
        self.selectedSegmentIndex = newIndex
        
        segmentIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        let constant: CGFloat = newIndex == 0 ? 5 : 15
        
        leading.isActive = false
        leading = segmentIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: (100 * CGFloat(newIndex)) + constant)
        leading.isActive = true
        
        UIView.animate(withDuration: 0.2, animations: {
            self.layoutIfNeeded()
        })
    }

}
