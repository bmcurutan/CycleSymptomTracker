//
//  NavigationBarButton.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/31/21.
//

import UIKit

class NavigationBarButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderColor = UIColor.primaryButtonColor.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        setTitleColor(.primaryButtonColor, for: .normal)
        setTitleColor(.primaryHighlightedButtonColor, for: .highlighted)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var isHighlighted: Bool {
        didSet {
            switch isHighlighted {
            case true:
                layer.borderColor = UIColor.primaryHighlightedButtonColor.cgColor
            case false:
                layer.borderColor = UIColor.primaryButtonColor.cgColor
            }
        }
    }
}
