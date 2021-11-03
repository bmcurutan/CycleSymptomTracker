//
//  HomeViewModel.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import Foundation

class HomeViewModel {
    var sections: [HomeSection] = [.today("Today"), .currentCycle("Current Cycle"), .analysis("Analysis")]

    var currentCycleDay: Int = UserDefaults.standard.integer(forKey: "CurrentCycleDay") 
    var numCycleDays: Int = 30

    var seeAllTitle: String = "See All →"
    var todaySubtitleNotCompleted: String = "Tap to track today's symptoms"
    var todaySubtitleCompleted: String = "Tap to see today's symptoms"

    var restartAlert: String = "Are you sure you want to restart cycle? Previously saved data will be lost."
    var restart: String = "Restart"
    var cancel: String = "Cancel"
}

enum HomeSection: Equatable {
    case today(String)
    case currentCycle(String)
    case analysis(String)

    static func == (lhs: HomeSection, rhs: HomeSection) -> Bool {
        switch (lhs, rhs) {
        case (.today, .today):
            return true
        case (.currentCycle, .currentCycle):
            return true
        default:
            return false
        }
    }
}
