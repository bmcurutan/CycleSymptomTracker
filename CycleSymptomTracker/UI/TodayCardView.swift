//
//  TodayCardView.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/5/21.
//

import UIKit

enum TodayCardType {
    case start
    case end
}

class TodayCardView: UIView {
    var cardType: TodayCardType?

    var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .headerHighlightedColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = .headerColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        backgroundColor = .white

        addSubview(topLabel)
        topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        topLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: topLabel.rightAnchor, constant: 16).isActive = true

        addSubview(bottomLabel)
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 4).isActive = true
        bottomLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: bottomLabel.rightAnchor, constant: 16).isActive = true
        bottomAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 8).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

