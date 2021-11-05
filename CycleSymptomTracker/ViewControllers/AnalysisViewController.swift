//
//  AnalysisViewController.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/2/21.
//

import Charts
import UIKit

class AnalysisViewController: UIViewController {
    private var viewModel: TrackerViewModel
    private var dateFormatter: DateFormatter

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(viewModel: TrackerViewModel, dateFormatter: DateFormatter) {
        self.viewModel = viewModel
        self.dateFormatter = dateFormatter
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Analysis"
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
        tableView.register(AnalysisTableViewCell.self, forCellReuseIdentifier: "AnalysisTableViewCell")

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

extension AnalysisViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].symptoms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisTableViewCell", for: indexPath) as! AnalysisTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? .backgroundColor : .white
        cell.title = viewModel.sections[indexPath.section].symptoms[indexPath.row]
        return cell
    }
}

extension AnalysisViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count - 1 // minus notes
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionHeader = SectionHeaderView()
        sectionHeader.title = viewModel.sections[section].title
        sectionHeader.translatesAutoresizingMaskIntoConstraints = false

        switch section {
        case 0:
            let header = UIView()
            header.backgroundColor = .highlightColor

            let infoLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont.systemFont(ofSize: 14)
                label.lineBreakMode = .byWordWrapping
                label.numberOfLines = 0
                label.text = viewModel.info
                label.textColor = .secondaryTextColor
                label.translatesAutoresizingMaskIntoConstraints = false
                return label
            }()
            
            header.addSubview(infoLabel)
            infoLabel.topAnchor.constraint(equalTo: header.topAnchor, constant: 12).isActive = true
            infoLabel.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 16).isActive = true
            header.rightAnchor.constraint(equalTo: infoLabel.rightAnchor, constant: 16).isActive = true

            header.addSubview(sectionHeader)
            sectionHeader.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 12).isActive = true
            sectionHeader.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
            header.bottomAnchor.constraint(equalTo: sectionHeader.bottomAnchor).isActive = true
            header.rightAnchor.constraint(equalTo: sectionHeader.rightAnchor).isActive = true

            return header

        default:
            return sectionHeader
        }
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}


