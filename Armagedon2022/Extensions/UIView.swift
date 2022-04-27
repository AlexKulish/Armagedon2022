//
//  UIView.swift
//  Armagedon2022
//
//  Created by Alex Kulish on 26.04.2022.
//

import UIKit

extension UIView {
    func setGradientBackground(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.name = "gradient"
        layer.insertSublayer(gradientLayer, at: 0)
    }
}
