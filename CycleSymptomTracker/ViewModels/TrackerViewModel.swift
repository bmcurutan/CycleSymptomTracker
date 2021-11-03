//
//  TrackerViewModel.swift
//  Cycle Symptom Tracker
//
//  Created by Bianca Curutan on 10/30/21.
//

import Foundation

class TrackerViewModel {
    var info: String = "Only data from the current cycle is displayed here. To access all historic data, use the Export function."

    var sections: [TrackerSection] = [
        TrackerSection(title: "Emotional",
                       symptoms: ["Anger",
                                  "Sensitivity",
                                  "Irritability",
                                  "Feeling overwhelmed",
                                  "Feeling hopeless",
                                  "Mood swings",
                                  "Depression",
                                  "Teariness",
                                  "Lack of interest in daily activities"],
                       type: .emotional),
        TrackerSection(title: "Mental",
                       symptoms: ["Anxiety",
                                  "Self-deprecating thoughts",
                                  "Mental fog",
                                  "Memory issues",
                                  "Speech issues",
                                  "Trouble concentrating",
                                  "Excess time on phone"],
                       type: .mental),
        TrackerSection(title: "Physical",
                       symptoms: ["Bloating",
                                  "Breast tenderness",
                                  "Sugar cravings",
                                  "Overall cravings",
                                  "Tiredness / low energy"],
                       type: .physical),
        TrackerSection(title: "Yes/No Questions",
                       symptoms: ["Cramps",
                                  "Headaches",
                                  "Acne",
                                  "Coordination issues",
                                  "Joint/muscle pain",
                                  "Back pain",
                                  "Panic attacks",
                                  "Obsessive thoughts",
                                  "Relationship conflicts",
                                  "Insomnia",
                                  "Nightmares"],
                       type: .yesNo),
        TrackerSection(title: "Notes", type: .notes)
    ]
}

struct TrackerSection {
    var title: String
    var symptoms: [String] = []
    var type: SymptomType

    enum SymptomType: Equatable {
        case emotional
        case mental
        case physical
        case yesNo
        case notes

        static func == (lhs: SymptomType, rhs: SymptomType) -> Bool {
            switch (lhs, rhs) {
            case (.emotional, .emotional):
                return true
    //        case (.mental, .mental):
    //            return true
    //        case (.physical, .physical):
    //            return true
    //        case (.yesNo, .yesNo):
    //            return true
            case (.notes, .notes):
                return true
            default:
                return false
            }
        }
    }
}
