//
//  HistoryViewController.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/1/21.
//

import UIKit

class HistoryViewController: UIViewController {
    // TODO put in convenience init
    private var viewModel = HomeViewModel()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "History"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
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
        return viewModel.currentCycleDay
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 1 ? .backgroundColor : .clear
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
        navigationController?.pushViewController(TrackerViewController(), animated: true) // TODO populate data
    }
}

