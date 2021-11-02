//
//  AnalysisTableViewCell.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/2/21.
//

import Charts
import UIKit

class AnalysisTableViewCell: UITableViewCell {
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

    private var chartView: CleanLineChartView = {
        let chartView = CleanLineChartView()
        chartView.backgroundColor = UIColor.accentColor.withAlphaComponent(0.2)
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(chartView)
        chartView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        chartView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: chartView.bottomAnchor, constant: 16).isActive = true
        contentView.rightAnchor.constraint(equalTo: chartView.rightAnchor, constant: 16).isActive = true
        chartView.heightAnchor.constraint(equalToConstant: 100).isActive = true

        // TODO clean up / remove
        var lineChartEntry = [ChartDataEntry]()
        for i in 0..<12 {
            let value = ChartDataEntry(x: Double(i), y: Double(i))
            lineChartEntry.append(value)
        }
        let line1 = LineChartDataSet(entries: lineChartEntry, label: nil)
        line1.circleColors = [.primaryButtonColor]
        line1.circleRadius = 4
        line1.colors = [.primaryButtonColor]
        let data = LineChartData()
        data.addDataSet(line1)
        chartView.data = data
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


