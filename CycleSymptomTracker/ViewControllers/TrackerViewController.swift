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
    private var viewModel: TrackerViewModel

    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .backgroundColor
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    init(viewModel: TrackerViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor

        let saveButton: NavigationBarButton = {
            let button = NavigationBarButton()
            button.title = "Save"
            button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
            return button
        }()
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: saveButton)

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SymptomTableViewCell.self, forCellReuseIdentifier: "SymptomTableViewCell")
        tableView.register(YesNoTableViewCell.self, forCellReuseIdentifier: "YesNoTableViewCell")
        tableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "NotesTableViewCell")
        tableView.separatorStyle = .none

        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.rightAnchor.constraint(equalTo: tableView.rightAnchor).isActive = true
        view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func saveButtonTapped() {
        // TODO save button tapped
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 92 {
                view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 92 {
            view.frame.origin.y = 92
        }
    }
}

extension TrackerViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let trackerSection = viewModel.sections[section]
        switch trackerSection.type {
        case .notes:
            return 1
        default:
            return trackerSection.symptoms.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let trackerSection = viewModel.sections[indexPath.section]
        switch trackerSection.type {
        case .notes:
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell", for: indexPath) as! NotesTableViewCell
            return cell
        case .yesNo:
            let cell = tableView.dequeueReusableCell(withIdentifier: "YesNoTableViewCell", for: indexPath) as! YesNoTableViewCell
            cell.backgroundColor = indexPath.row % 2 == 0 ? .backgroundColor : .white
            cell.title = trackerSection.symptoms[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomTableViewCell", for: indexPath) as! SymptomTableViewCell
            cell.backgroundColor = indexPath.row % 2 == 0 ? .backgroundColor : .white
            cell.title = trackerSection.symptoms[indexPath.row]
            return cell
        }
    }
}

extension TrackerViewController: UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = SectionHeaderView()
        header.title = viewModel.sections[section].title
        return header
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
}

private class SymptomTableViewCell: UITableViewCell {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.thumbTintColor = .accentColor
        slider.minimumTrackTintColor = .accentColor
        slider.maximumTrackTintColor = .borderColor
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()

    private var sliderValues: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(slider)
        slider.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        slider.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: slider.rightAnchor, constant: 16).isActive = true
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)

        contentView.addSubview(sliderValues)
        sliderValues.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 4).isActive = true
        sliderValues.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: sliderValues.bottomAnchor, constant: 12).isActive = true
        contentView.rightAnchor.constraint(equalTo: sliderValues.rightAnchor, constant: 8).isActive = true

        for i in 1...10 { // minimumValue...maximumValue
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = "\(i)"
            label.textAlignment = .center
            sliderValues.addArrangedSubview(label)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func sliderValueChanged(_ sender: UISlider) {
        // Snap to closest integer value
        sender.value = round(sender.value)
    }
}

private class NotesTableViewCell: UITableViewCell {
    private var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.borderColor.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 8
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .primaryTextColor
        textView.tintColor = .accentColor
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .highlightColor

        textView.delegate = self
        contentView.addSubview(textView)
        textView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        textView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: textView.rightAnchor, constant: 16).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NotesTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

private class YesNoTableViewCell: UITableViewCell {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var control: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Yes", "No"])
        control.layer.borderColor = UIColor.borderColor.cgColor
        control.layer.borderWidth = 1
        control.selectedSegmentTintColor = .accentColor
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(control)
        control.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        control.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: control.bottomAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: control.rightAnchor, constant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
