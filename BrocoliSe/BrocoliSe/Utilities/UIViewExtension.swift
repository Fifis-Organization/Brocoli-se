//
//  UIViewExtension.swift
//  BrocoliSe
//
//  Created by Samuel Sales on 23/09/21.
//

import Foundation
import UIKit
extension UIView {

    func shakeEffect(horizontaly: CGFloat = 0, vertically: CGFloat = 0) {
        
        let animation = CABasicAnimation(keyPath: "position")
        
        let haptic = UIImpactFeedbackGenerator(style: .light)
        haptic.impactOccurred()
        
        animation.duration = 0.05
        animation.repeatCount = 4
        animation.autoreverses = true
        
        animation.fromValue = NSValue(cgPoint: CGPoint(x: center.x - horizontaly, y: center.y - vertically))
        animation.toValue = NSValue(cgPoint: CGPoint(x: center.x + horizontaly, y: center.y + vertically))
        
        layer.add(animation, forKey: "position")
    }

}

extension UIColor {
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
