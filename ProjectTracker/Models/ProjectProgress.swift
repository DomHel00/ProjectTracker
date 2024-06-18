//
//  ProjectProgress.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import Foundation

enum ProjectProgress: Int, CaseIterable {
    case initialization = 0
    case inDevelopment = 1
    case interrupt = 2
    case completed = 3
    
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
    
    static var allTitles: [String] {
        var titles = [String]()
        for projectProgress in ProjectProgress.allCases {
            titles.append(projectProgress.title)
        }
        return titles
    }
}
