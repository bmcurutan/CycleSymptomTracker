//
//  InfoViewController.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/1/21.
//

import UIKit

class InfoViewController: UIViewController {
    private var viewModel = InfoViewModel()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .headerColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var bodyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        titleLabel.text = viewModel.title
        view.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        view.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        bodyLabel.text = viewModel.body
        view.addSubview(bodyLabel)
        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        bodyLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(greaterThanOrEqualTo: bodyLabel.bottomAnchor, constant: 16).isActive = true
        view.rightAnchor.constraint(equalTo: bodyLabel.rightAnchor, constant: 16).isActive = true
    }
}
