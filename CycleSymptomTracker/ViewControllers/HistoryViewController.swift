//
//  HistoryViewController.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/1/21.
//

import UIKit

class HistoryViewController: UIViewController {
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
        title = "History"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
    }
}

extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.currentCycleDay
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 1 ? .backgroundColor : .white
        cell.isCompleted = indexPath.row % 2 == 1 ? true : false // TODO
        let delta = -tableView.numberOfRows(inSection: indexPath.section) + indexPath.row
        let modifiedDate = Calendar.current.date(byAdding: .day, value: delta, to: Date())!
        cell.title = "Day \(indexPath.row + 1) - \(dateFormatter.string(from: modifiedDate).uppercased())"
        return cell
    }
}

extension HistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(TrackerViewController(viewModel: trackerViewModel), animated: true)
    }
}

