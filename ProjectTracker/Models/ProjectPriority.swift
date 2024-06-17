//
//  ProjectPriority.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import Foundation

enum ProjectPriority: Int, CaseIterable {
    case none = 0
    case low = 1
    case normal = 2
    case high = 3
    
    var title: String {
        switch self {
        case .none:
            return "None"
        case .low:
            return "Low"
        case .normal:
            return "Normal"
        case .high:
            return "High"
        }
    }
    
    static var allTitles: [String] {
        var titles = [String]()
        for projectPriority in ProjectPriority.allCases {
            titles.append(projectPriority.title)
        }
        return titles
    }
}
