//
//  ProjectProgress.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

// MARK: Imports
import Foundation

// MARK: ProjectProgress enum
enum ProjectProgress: Int, CaseIterable {
    // MARK: Cases
    case initialization = 0
    case inDevelopment = 1
    case interrupt = 2
    case completed = 3
    
    // MARK: Computed properties
    /// Returns the title for case.
    var title: String {
        switch self {
        case .initialization:
            return "Initialization".localized()
        case .inDevelopment:
            return "In development".localized()
        case .interrupt:
            return "Interrupt".localized()
        case .completed:
            return "Completed".localized()
        }
    }
    
    /// Returns the list of all titles.
    static var allTitles: [String] {
        var titles = [String]()
        for projectProgress in ProjectProgress.allCases {
            titles.append(projectProgress.title)
        }
        return titles
    }
}
