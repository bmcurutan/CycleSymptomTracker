//
//  UIView+Ext.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/1/21.
//

import UIKit

extension UIView {
    func addHorizontalGradient(alpha: CGFloat = 0.4) {
        if let _ = layer.sublayers?.first as? CAGradientLayer { return }
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.accentColor.cgColor, UIColor.highlightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        layer.insertSublayer(gradient, at: 0)
      }
}
