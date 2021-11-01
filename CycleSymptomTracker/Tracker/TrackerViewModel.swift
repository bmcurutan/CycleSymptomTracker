//
//  TrackerViewModel.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import Foundation

class TrackerViewModel {
    var sections: [TrackerSection] = [.symptoms("Symptoms"), .notes("Notes")]

    var symptoms: [String] = [
        "Feeling Overwhelmed",
        "Feelings of Hopelessness",
        "Mood Swings",
        "Sadness / Depression",
        "Teariness"
    ]
}

enum TrackerSection: Equatable {
    case symptoms(String)
    case notes(String)

    static func == (lhs: TrackerSection, rhs: TrackerSection) -> Bool {
        switch (lhs, rhs) {
        case (.symptoms, .symptoms):
            return true
        case (.notes, .notes):
            return true
        default:
            return false
        }
    }
}

