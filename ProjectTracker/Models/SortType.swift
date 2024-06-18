//
//  SortType.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 17.06.2024.
//

import Foundation

enum SortType: Int, CaseIterable {
    case byTitle = 0
    case byPriority = 1
    case byProgress = 2
    case byCreationDate = 3
    
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
