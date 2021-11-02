//
//  HomeTableViewCells.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/31/21.
//

import Charts
import UIKit

class TodayTableViewCell: UITableViewCell {
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

    private var cycleCardView: TodayCardView = {
        let view = TodayCardView()
        view.topLabel.text = "CYCLE LENGTH"
        view.bottomLabel.text = "30 days"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var trackedCardView: TodayCardView = {
        let view = TodayCardView()
        view.topLabel.text = "DAYS TRACKED"
        view.bottomLabel.text = "\(UserDefaults.standard.integer(forKey: "CurrentCycleDay"))"
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
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .headerColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var chartView: CleanScatterChartView = {
        let chartView = CleanScatterChartView()
        chartView.translatesAutoresizingMaskIntoConstraints = false
        return chartView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let cardWidth = (UIScreen.main.bounds.width - 16 - 8 - 16) / 2
        contentView.addSubview(cycleCardView)
        cycleCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        cycleCardView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        cycleCardView.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true
        contentView.addSubview(trackedCardView)
        trackedCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        trackedCardView.leftAnchor.constraint(equalTo: cycleCardView.rightAnchor, constant: 8).isActive = true
        trackedCardView.widthAnchor.constraint(equalToConstant: cardWidth).isActive = true

        contentView.addSubview(icon)
        icon.topAnchor.constraint(equalTo: cycleCardView.bottomAnchor, constant: 16).isActive = true
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
        chartView.topAnchor.constraint(equalTo: icon.bottomAnchor, constant: 16).isActive = true
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
}

private class TodayCardView: UIView {
    var topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .headerHighlightedColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var bottomLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        label.textColor = .headerColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        backgroundColor = .white

        addSubview(topLabel)
        topLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        topLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: topLabel.rightAnchor, constant: 16).isActive = true

        addSubview(bottomLabel)
        bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 4).isActive = true
        bottomLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        rightAnchor.constraint(equalTo: bottomLabel.rightAnchor, constant: 16).isActive = true
        bottomAnchor.constraint(equalTo: bottomLabel.bottomAnchor, constant: 8).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class HistoryTableViewCell: UITableViewCell {
    var isCompleted: Bool = false {
        didSet {
            icon.image = isCompleted ? UIImage(systemName: "checkmark.square") : UIImage(systemName: "square")
        }
    }

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    private var icon: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "square")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .primaryTextColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .primaryTextColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var chevron: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right")?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .secondaryTextColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubview(icon)
        icon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        icon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        icon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        icon.heightAnchor.constraint(equalToConstant: 20).isActive = true

        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: icon.rightAnchor, constant: 8).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true

        contentView.addSubview(chevron)
        contentView.rightAnchor.constraint(equalTo: chevron.rightAnchor, constant: 16).isActive = true
        chevron.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 12).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        contentView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        contentView.rightAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 16).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
