//
//  HomeViewController.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import UIKit

class HomeViewController: UIViewController {
    private var homeViewModel = HomeViewModel()
    private var trackerViewModel = TrackerViewModel()
    private var maxRows = 5

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
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
        setUpNavigationBar()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: "TodayTableViewCell")
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: "HistoryTableViewCell")
        tableView.register(AnalysisTableViewCell.self, forCellReuseIdentifier: "AnalysisTableViewCell")
        tableView.register(SectionSubheaderTableViewCell.self, forCellReuseIdentifier: "SectionSubheaderTableViewCell")
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true

        // TODO remove
        UserDefaults.standard.setValue(10, forKey: "CurrentCycleDay")
    }

    private func setUpNavigationBar() {
        let iconButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setImage(UIImage(systemName: "arrow.clockwise.heart"), for: .normal)
            button.setImage(UIImage(systemName: "arrow.clockwise.heart")?.withTintColor(.headerHighlightedColor, renderingMode: .alwaysOriginal), for: .highlighted)
            button.imageView?.translatesAutoresizingMaskIntoConstraints = false
            button.imageView?.widthAnchor.constraint(equalToConstant: 32).isActive = true
            button.imageView?.heightAnchor.constraint(equalToConstant: 32).isActive = true
            return button
        }()
        iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: iconButton)

        let restartButton: NavigationBarButton = {
            let button = NavigationBarButton()
            button.setTitle("RESTART CYCLE", for: .normal)
            return button
        }()
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: restartButton)
    }

    @objc private func iconButtonTapped() {
        present(InfoViewController(), animated: true, completion: nil)
    }

    @objc private func restartButtonTapped() {
        let alert = UIAlertController(title: nil, message: homeViewModel.restartAlert, preferredStyle: .alert)
        alert.view.tintColor = .primaryButtonColor
        alert.addAction(UIAlertAction(title: homeViewModel.restart, style: .default, handler: { _ in
            UserDefaults.standard.setValue(0, forKey: "CurrentCycleDay")
        }))
        alert.addAction(UIAlertAction(title: homeViewModel.cancel, style: .default, handler: nil))
        present(alert, animated: true)
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch homeViewModel.sections[section] {
        case .today:
            return 1
        case .history:
            return min(homeViewModel.currentCycleDay, maxRows)
        case .analysis:
            // We already know sections.first.symptoms.count > maxRows
            return maxRows + 1 // + subheader
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch homeViewModel.sections[indexPath.section] {
        case .today:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodayTableViewCell", for: indexPath) as! TodayTableViewCell
            cell.isCompleted = true // TODO
            cell.title = "Day \(homeViewModel.currentCycleDay + 1) - \(dateFormatter.string(from: Date()).uppercased())"
            cell.subtitle = cell.isCompleted ? homeViewModel.todaySubtitleCompleted : homeViewModel.todaySubtitleCompleted
            return cell
        case .history:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryTableViewCell", for: indexPath) as! HistoryTableViewCell
            cell.backgroundColor = indexPath.row % 2 == 1 ? .backgroundColor : .white
            cell.isCompleted = indexPath.row % 2 == 1 ? true : false // TODO
            let delta = -tableView.numberOfRows(inSection: indexPath.section) + indexPath.row
            let modifiedDate = Calendar.current.date(byAdding: .day, value: delta, to: Date())!
            cell.title = "Day \(indexPath.row + 1) - \(dateFormatter.string(from: modifiedDate).uppercased())"
            return cell
        case .analysis:
            let trackerSection = trackerViewModel.sections.first
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "SectionSubheaderTableViewCell", for: indexPath) as! SectionSubheaderTableViewCell
                cell.title = trackerSection?.title.uppercased()
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: "AnalysisTableViewCell", for: indexPath) as! AnalysisTableViewCell
                cell.backgroundColor = indexPath.row % 2 == 1 ? .backgroundColor : .white
                cell.title = trackerViewModel.sections.first?.symptoms[indexPath.row - 1]
                return cell
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return homeViewModel.sections.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(TrackerViewController(viewModel: trackerViewModel), animated: true)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        header.delegate = self
        header.section = section

        switch homeViewModel.sections[section] {
        case let .today(title):
            header.title = title
        case let .history(title):
            header.title = title
            if homeViewModel.currentCycleDay > maxRows {
                header.buttonTitle = homeViewModel.seeAllTitle
            }
        case let .analysis(title):
            header.title = title
            header.buttonTitle = homeViewModel.seeAllTitle
        }
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension HomeViewController: SectionHeaderViewDelegate {
    func buttonTapped(section: Int?) {
        guard let section = section else { return }

        switch homeViewModel.sections[section] {
        case .history:
            navigationController?.pushViewController(HistoryViewController(homeViewModel: homeViewModel, trackerViewModel: trackerViewModel, dateFormatter: dateFormatter), animated: true)
        case .analysis:
            navigationController?.pushViewController(AnalysisViewController(viewModel: trackerViewModel, dateFormatter: dateFormatter), animated: true)
        default:
            break
        }
    }
}
