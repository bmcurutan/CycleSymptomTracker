//
//  SectionHeaderView.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/31/21.
//

import UIKit

protocol SectionHeaderViewDelegate {
    func buttonTapped(section: Int?)
}

class SectionHeaderView: UIView {
    var delegate: SectionHeaderViewDelegate?

    var section: Int?

    var title: String? {
        didSet {
            if let title = title {
                titleLabel.text = title.uppercased()
            }
        }
    }

    var buttonTitle: String? {
        didSet {
            if let title = buttonTitle {
                rightButton.setTitle(title.uppercased(), for: .normal)
                rightButton.isHidden = false
            }
        }
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var rightButton: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.setTitleColor(.primaryButtonColor, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .headerTextColor

        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true

        addSubview(rightButton)
        rightButton.leftAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
        rightAnchor.constraint(equalTo: rightButton.rightAnchor, constant: 8).isActive = true
        rightButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        delegate?.buttonTapped(section: section)
    }
}
