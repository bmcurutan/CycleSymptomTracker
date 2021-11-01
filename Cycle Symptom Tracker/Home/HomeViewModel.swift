//
//  HomeViewModel.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import Foundation

class HomeViewModel {
    var sections: [HomeSection] = [.today("Today"), .history("History"), .analysis("Analysis")]

    var currentCycleDay: Int = UserDefaults.standard.integer(forKey: "CurrentCycleDay") 
    var numCycleDays: Int = 30

    var seeAllTitle: String = "See All →"
}

enum HomeSection: Equatable {
    case today(String)
    case history(String)
    case analysis(String)

    static func == (lhs: HomeSection, rhs: HomeSection) -> Bool {
        switch (lhs, rhs) {
        case (.today, .today):
            return true
        case (.history, .history):
            return true
        default:
            return false
        }
    }
}
