//
//  AnalysisViewController.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/2/21.
//

import Charts
import UIKit

class AnalysisViewController: UIViewController {
    // TODO put in convenience init
    private var viewModel = TrackerViewModel()

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
        title = "Analysis"
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AnalysisTableViewCell.self, forCellReuseIdentifier: "AnalysisTableViewCell")

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 16).isActive = true
        view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
    }
}

extension AnalysisViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].symptoms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisTableViewCell", for: indexPath) as! AnalysisTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 1 ? .backgroundColor : .clear
        return cell
    }
}

extension AnalysisViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        navigationController?.pushViewController(TrackerViewController(), animated: true) // TODO populate data
    }
}


