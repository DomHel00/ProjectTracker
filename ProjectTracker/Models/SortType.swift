//
//  SortType.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 17.06.2024.
//

// MARK: Imports
import Foundation

// MARK: SortType enum
enum SortType: Int, CaseIterable {
    // MARK: Cases
    case byTitle = 0
    case byPriority = 1
    case byProgress = 2
    case byCreationDate = 3
    
    // MARK: Computed properties
    /// Returns the title for case.
    var title: String {
        switch self {
        case .byTitle:
            return "By title".localized()
        case .byPriority:
            return "By priority".localized()
        case .byProgress:
            return "By progress".localized()
        case .byCreationDate:
            return "By creation date".localized()
        }
    }
    
    /// Returns the sort descriptor key for case.
    var sortDescriptorKey: String {
        switch self {
        case .byTitle:
            return #keyPath(Project.projectTitle)
        case .byPriority:
            return #keyPath(Project.projectPriorityIndex)
        case .byProgress:
            return #keyPath(Project.projectProgressIndex)
        case .byCreationDate:
            return #keyPath(Project.creationDate)
        }
    }
}
