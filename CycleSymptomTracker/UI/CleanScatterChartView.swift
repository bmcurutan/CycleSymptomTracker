//
//  CleanScatterChartView.swift
//  CycleSymptomTracker
//
//  Created by Bianca Curutan on 11/1/21.
//

import Charts
import UIKit

class CleanScatterChartView: ScatterChartView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = UIColor.white.withAlphaComponent(0.4)
        isUserInteractionEnabled = false
        chartDescription?.enabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLabelsEnabled = false
        xAxis.drawAxisLineEnabled = false
        rightAxis.enabled = false
        leftAxis.enabled = false
        drawBordersEnabled = false
        legend.form = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
