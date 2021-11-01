//
//  HomeTableViewCells.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/31/21.
//

import UIKit

class TodayTableViewCell: UITableViewCell {
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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .highlightColor

        contentView.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addHorizontalGradient()
    }
}


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
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class AnalysisTableViewCell: UITableViewCell {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func addHorizontalGradient(alpha: CGFloat = 0.4) {
        if let _ = layer.sublayers?.first as? CAGradientLayer { return }
        let gradient = CAGradientLayer()
        gradient.frame = bounds
        gradient.colors = [UIColor.highlightColor.cgColor, UIColor.white.cgColor]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
        layer.insertSublayer(gradient, at: 0)
      }
}
