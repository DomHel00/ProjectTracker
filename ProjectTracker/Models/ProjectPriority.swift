//
//  ProjectPriority.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

// MARK: Imports
import Foundation

// MARK: ProjectPriority enum
enum ProjectPriority: Int, CaseIterable {
    // MARK: Cases
    case none = 0
    case low = 1
    case normal = 2
    case high = 3
    
    // MARK: Computed properties
    /// Returns the title for case.
    var title: String {
        switch self {
        case .none:
            return "None".localized()
        case .low:
            return "Low".localized()
        case .normal:
            return "Normal".localized()
        case .high:
            return "High".localized()
        }
    }
    
    /// Returns the list of all titles.
    static var allTitles: [String] {
        var titles = [String]()
        for projectPriority in ProjectPriority.allCases {
            titles.append(projectPriority.title)
        }
        return titles
    }
}
