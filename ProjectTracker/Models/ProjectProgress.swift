//
//  ProjectProgress.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import Foundation

enum ProjectProgress: String, CaseIterable {
   case initialization = "Initialization"
   case inDevelopment = "In development"
   case interrupt = "Interrupt"
   case completed = "Completed"
    
    static var allTitles: [String] {
        var titles = [String]()
        for projectProgress in ProjectProgress.allCases {
            titles.append(projectProgress.rawValue)
        }
        return titles
    }
}
