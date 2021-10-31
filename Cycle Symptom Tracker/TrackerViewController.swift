//
//  TrackerViewController.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

/* TODO
 * Day #
 * Dial
 * Text field
 */
import UIKit

class TrackerViewController: UIViewController {
    private var viewModel = TrackerViewModel()

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SymptomTableViewCell.self, forCellReuseIdentifier: "SymptomTableViewCell")
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
    }
}

extension TrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.symptoms.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomTableViewCell", for: indexPath) as! SymptomTableViewCell
        cell.textLabel?.text = viewModel.symptoms[indexPath.row]
        return cell
    }
}

extension TrackerViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return TrackerFooterView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

private class SymptomTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class TrackerFooterView: UIView {
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Notes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 14)
//        textView.textColor = .primaryTextColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray

        addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        addSubview(textView)
        textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        textView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: textView.rightAnchor, constant: 16).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
