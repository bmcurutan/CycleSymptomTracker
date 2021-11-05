//
//  CurrentCycleViewController.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/1/21.
//

import UIKit

class CurrentCycleViewController: UIViewController {
    private var homeViewModel: HomeViewModel
    private var trackerViewModel: TrackerViewModel
    private var dateFormatter: DateFormatter

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(homeViewModel: HomeViewModel, trackerViewModel: TrackerViewModel, dateFormatter: DateFormatter) {
        self.homeViewModel = homeViewModel
        self.trackerViewModel = trackerViewModel
        self.dateFormatter = dateFormatter
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Current Cycle"
        view.backgroundColor = .backgroundColor

        let exportButton: NavigationBarButton = {
            let button = NavigationBarButton()
            button.title = "Export"
            return button
        }()
        exportButton.addTarget(self, action: #selector(exportButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exportButton)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(CurrentCycleTableViewCell.self, forCellReuseIdentifier: "CurrentCycleTableViewCell")

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
    }

    @objc private func exportButtonTapped() {
        // TODO export button
    }
}

extension CurrentCycleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.currentCycleDay
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentCycleTableViewCell", for: indexPath) as! CurrentCycleTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? .backgroundColor : .white
        cell.isCompleted = indexPath.row % 2 == 0 ? true : false // TODO
        let delta = -tableView.numberOfRows(inSection: indexPath.section) + indexPath.row
        let modifiedDate = Calendar.current.date(byAdding: .day, value: delta, to: Date())!
        cell.title = "Day \(indexPath.row + 1) - \(dateFormatter.string(from: modifiedDate).uppercased())"
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.backgroundColor = .highlightColor

        let infoLabel: UILabel = {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.lineBreakMode = .byWordWrapping
            label.numberOfLines = 0
            label.text = trackerViewModel.info
            label.textColor = .secondaryTextColor
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()

        header.addSubview(infoLabel)
        infoLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 12).isActive = true
        infoLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 16).isActive = true
        header.bottomAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12).isActive = true
        header.rightAnchor.constraint(equalTo: infoLabel.rightAnchor, constant: 16).isActive = true

        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension CurrentCycleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(TrackerViewController(viewModel: trackerViewModel), animated: true)
    }
}

