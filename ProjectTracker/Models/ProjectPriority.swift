//
//  ProjectPriority.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import Foundation

enum ProjectPriority: String, CaseIterable {
    case none = "None"
    case low = "Low"
    case normal = "Normal"
    case high = "High"
    
    static var allTitles: [String] {
        var titles = [String]()
        for projectPriority in ProjectPriority.allCases {
            titles.append(projectPriority.rawValue)
        }
        return titles
    }
}
