//
//  HomeTableViewCells.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/31/21.
//

import Charts
import UIKit

protocol TodayTableViewCellDelegate {
    func cycleDateCardTapped(with type: TodayCardType)
}

class TodayTableViewCell: UITableViewCell {
    var delegate: TodayTableViewCellDelegate?

    var isCompleted: Bool = false {
        didSet {
            icon.image = isCompleted ? UIImage(systemName: "checkmark.circle.fill") : UIImage(systemName: "plus.circle.fill")
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    private var startDateCardView: TodayCardView = {
        let view = TodayCardView()
        view.cardType = .start
        view.topLabel.text = "CYCLE START DATE"
        view.bottomLabel.text = "Nov 1, 2021" // TODO start date
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var endDateCardView: TodayCardView = {
        let view = TodayCardView()
        view.cardType = .end
        view.topLabel.text = "CYCLE END DATE"
        view.bottomLabel.text = "Nov 30, 2021" // TODO end date
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus.circle.fill"))
        imageView.tintColor = .primaryButtonColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .headerColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var chartView: CleanScatterChartView = {
        let chartView = CleanScatterChartView()
        chartView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let cardWidth = (UIScreen.main.bounds.width - 16 - 8 - 16) / 2
        let startDateTap = UITapGestureRecognizer(target: self, action: #selector(startDateCardTapped))
        startDateCardView.addGestureRecognizer(startDateTap)
        contentView.addSubview(startDateCardView)
        startDateCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        startDateCardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        startDateCardView.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true

        let endDateTap = UITapGestureRecognizer(target: self, action: #selector(endDateCardTapped))
        endDateCardView.addGestureRecognizer(endDateTap)
        contentView.addSubview(endDateCardView)
        endDateCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        endDateCardView.leftAnchor.constraint(equalTo: startDateCardView.rightAnchor, constant: 8).isActive = true
        endDateCardView.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true

        contentView.addSubview(icon)
        icon.topAnchor.constraint(equalTo: endDateCardView.bottomAnchor, constant: 16).isActive = true
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 40).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: icon.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(subtitleLabel)
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
        subtitleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        contentView.rightAnchor.constraint(equalTo: subtitleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(chartView)
        chartView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 16).isActive = true
        chartView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: chartView.rightAnchor, constant: 16).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // TODO remove test data
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<12 {
            let value = ChartDataEntry(x: Double(i), y: Double(i))
            lineChartEntry.append(value)
        }
        let line1 = ScatterChartDataSet(entries: lineChartEntry, label: nil)
        line1.setScatterShape(.circle)
        line1.scatterShapeSize = 8
        line1.colors = [.primaryButtonColor]
        let data = ScatterChartData()
        data.addDataSet(line1)
        chartView.data = data
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.addVerticalGradient()
    }

    @objc private func startDateCardTapped() {
        delegate?.cycleDateCardTapped(with: .start)
    }

    @objc private func endDateCardTapped() {
        delegate?.cycleDateCardTapped(with: .end)
    }
}
