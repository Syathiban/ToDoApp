//
//  HelperExtensions.swift
//  CloudFunctions
//
//  Created by Athiban on 24.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    private func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0.0,y: 0.0,width: 1.0,height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    func setBackgroundColor(color: UIColor, forUIControlState state: UIControlState) {
        self.setBackgroundImage(imageWithColor(color: color), for: state)
    }
    
}


extension UIView {
    
    
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        let gradient = CAGradientLayer()
        gradient.frame = self.layer.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)

        self.layer.insertSublayer(gradient, at: 0)
        
    }
    
    func addVerticalGradientLayer2(topColor:UIColor, bottomColor:UIColor) {
      let gradient = CAGradientLayer()
    gradient.frame = self.bounds
    gradient.colors = [
    topColor.cgColor,
    bottomColor.cgColor
    ]
    gradient.locations = [0.0, 2.0]
    gradient.startPoint = CGPoint(x: 0, y: 0)
    gradient.endPoint = CGPoint(x: 0, y: 1)
    self.layer.insertSublayer(gradient, at: 0)
      
    }
    
    func viewloadSub() {
        let gradient = CAGradientLayer()
        gradient.frame = self.layer.bounds
    }
}
