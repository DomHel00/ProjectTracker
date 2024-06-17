//
//  ProjectModel.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import Foundation

struct ProjectModel {
    var projectTitle: String
    var projectDescription: String?
    var projectPriority: ProjectPriority
    var projectProgress: ProjectProgress
    var creationDate: Date
    var icon: Data?
    var projectURL: URL?
    
    init(projectTitle: String, projectDescription: String? = nil, projectPriority: ProjectPriority, projectProgress: ProjectProgress, creationDate: Date, icon: Data? = nil, projectURL: URL?) {
        self.projectTitle = projectTitle
        self.projectDescription = projectDescription
        self.projectPriority = projectPriority
        self.projectProgress = projectProgress
        self.creationDate = creationDate
        self.icon = icon
        self.projectURL = projectURL
    }
}
