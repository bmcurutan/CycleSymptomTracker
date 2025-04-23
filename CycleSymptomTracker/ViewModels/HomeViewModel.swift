//
//  HomeViewModel.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import Foundation

class HomeViewModel {
    let title = "Cycle Symptom Tracker"
    let sections: [HomeSection] = [.today("Today"), .currentCycle("Current Cycle"), .analysis("Analysis")]

    let currentCycleDay = UserDefaults.standard.integer(forKey: "CurrentCycleDay")
    let numCycleDays = 40

    let seeAllTitle = "See All →"
    let todaySubtitleNotCompleted = "Tap to track today's symptoms"
    let todaySubtitleCompleted = "Tap to see today's symptoms"

    let startDateAlert = "Are you sure you want to update the start date for the current cycle?"
    let endDateAlert = "Are you sure you want to update the end date for the current cycle?"
    // TODO current/ongoing cycle vs cycle ended
    let update = "Update"
    let cancel = "Cancel"
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
