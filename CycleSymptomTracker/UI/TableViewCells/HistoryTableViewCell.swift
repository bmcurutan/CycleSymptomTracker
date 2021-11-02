//
//  HistoryTableViewCell.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/2/21.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    var isCompleted: Bool = false {
        didSet {
            icon.image = isCompleted ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "square")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .primaryTextColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var chevron: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .secondaryTextColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(chevron)
        contentView.rightAnchor.constraint(equalTo: chevron.rightAnchor, constant: 16).isActive = true
        chevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 12).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
