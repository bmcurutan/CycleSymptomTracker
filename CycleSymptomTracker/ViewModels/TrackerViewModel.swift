//
//  TrackerViewModel.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import Foundation

class TrackerViewModel {
    var sections: [TrackerSection] = [
        .emotional("Emotional", ["Anger",
                                 "Sensitivity",
                                 "Irritability",
                                 "Feeling overwhelmed",
                                 "Feeling hopeless",
                                 "Mood swings",
                                 "Depression",
                                 "Teariness",
                                 "Lack of interest in daily activities"]),
        .mental("Mental", ["Anxiety",
                           "Self-deprecating thoughts",
                           "Mental fog",
                           "Memory issues",
                           "Speech issues",
                           "Trouble concentrating",
                           "Excess time on phone"]),
        .physical("Physical", ["Bloating",
                               "Breast tenderness",
                               "Sugar cravings",
                               "Overall cravings",
                               "Tiredness / low energy"]),
        .yesNo("Yes/No Questions", ["Cramps",
                                    "Headaches",
                                    "Acne",
                                    "Coordination issues",
                                    "Joint/muscle pain",
                                    "Back pain",
                                    "Panic attacks",
                                    "Obsessive thoughts",
                                    "Relationship conflicts",
                                    "Insomnia",
                                    "Nightmares"]),
        .notes("Notes")
    ]
}

enum TrackerSection: Equatable {
    // (Title, Symptom)
    case emotional(String, [String])
    case mental(String, [String])
    case physical(String, [String])
    case yesNo(String, [String])
    case notes(String)

    static func == (lhs: TrackerSection, rhs: TrackerSection) -> Bool {
        switch (lhs, rhs) {
        case (.emotional, .emotional):
            return true
        case (.mental, .mental):
            return true
        case (.physical, .physical):
            return true
        case (.yesNo, .yesNo):
            return true
        case (.notes, .notes):
            return true
        default:
            return false
        }
    }
}


