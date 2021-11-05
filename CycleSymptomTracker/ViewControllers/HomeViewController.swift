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
        tableView.backgroundView = UIView(frame: tableView.frame)
        tableView.backgroundView?.backgroundColor = .white
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
        view.backgroundColor = .backgroundColor

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TodayTableViewCell.self, forCellReuseIdentifier: "TodayTableViewCell")
        tableView.register(CurrentCycleTableViewCell.self, forCellReuseIdentifier: "CurrentCycleTableViewCell")
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
            let image = UIImage(systemName: "arrow.clockwise.heart")
            button.setImage(image, for: .normal)
            button.setImage(image?.withTintColor(.headerHighlightedColor, renderingMode: .alwaysOriginal), for: .highlighted)
            return button
        }()
        iconButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
        iconButton.imageView?.widthAnchor.constraint(equalToConstant: 32).isActive = true
        iconButton.imageView?.heightAnchor.constraint(equalToConstant: 32).isActive = true
        iconButton.addTarget(self, action: #selector(iconButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: iconButton)

        let restartButton: NavigationBarButton = {
            let button = NavigationBarButton()
            button.title = "Restart Cycle"
            return button
        }()
        restartButton.addTarget(self, action: #selector(restartButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: restartButton)
    }

    @objc private func iconButtonTapped() {
        present(InfoViewController(), animated: true, completion: nil)
    }

    @objc private func restartButtonTapped(_ sender: NavigationBarButton) {
        let alert = UIAlertController(title: nil, message: homeViewModel.restartAlert, preferredStyle: .alert)
        alert.view.tintColor = .primaryButtonColor
        alert.addAction(UIAlertAction(title: homeViewModel.restart, style: .default, handler: { _ in
            sender.status = .loading
//            UserDefaults.standard.setValue(0, forKey: "CurrentCycleDay")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // TODO REMOVE
                sender.status = .done
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                sender.status = .standby
            }
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
        case .currentCycle:
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
            cell.isCompleted = false // TODO
            cell.title = "Day \(homeViewModel.currentCycleDay + 1) - \(dateFormatter.string(from: Date()).uppercased())"
            cell.subtitle = cell.isCompleted ? homeViewModel.todaySubtitleCompleted : homeViewModel.todaySubtitleNotCompleted
            return cell
        case .currentCycle:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentCycleTableViewCell", for: indexPath) as! CurrentCycleTableViewCell
            cell.backgroundColor = indexPath.row % 2 == 0 ? .backgroundColor : .white
            cell.isCompleted = indexPath.row % 2 == 0 ? true : false // TODO
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
                cell.backgroundColor = indexPath.row % 2 == 0 ? .backgroundColor : .white
                cell.title = trackerViewModel.sections.first?.symptoms[indexPath.row - 1]
                cell.isUserInteractionEnabled = false
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
        case let .currentCycle(title):
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
        case .currentCycle:
            navigationController?.pushViewController(CurrentCycleViewController(homeViewModel: homeViewModel, trackerViewModel: trackerViewModel, dateFormatter: dateFormatter), animated: true)
        case .analysis:
            navigationController?.pushViewController(AnalysisViewController(viewModel: trackerViewModel, dateFormatter: dateFormatter), animated: true)
        default:
            break
        }
    }
}
