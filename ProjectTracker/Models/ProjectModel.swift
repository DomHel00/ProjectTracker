//
//  ProjectModel.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import Foundation

struct ProjectModel {
    var projectTitle: String?
    var projectDescription: String?
    var projectPriority: String?
    var projectProgress: String?
    var creationDate: Date?
    var completionDate: Date?
    var icon: Data?
    
    init(projectTitle: String? = nil, projectDescription: String? = nil, projectPriority: String? = nil, projectProgress: String? = nil, creationDate: Date? = nil, completionDate: Date? = nil, icon: Data? = nil) {
        self.projectTitle = projectTitle
        self.projectDescription = projectDescription
        self.projectPriority = projectPriority
        self.projectProgress = projectProgress
        self.creationDate = creationDate
        self.completionDate = completionDate
        self.icon = icon
    }
}
