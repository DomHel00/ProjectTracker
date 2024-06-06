//
//  Project+CoreDataProperties.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 29.05.2024.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var projectID: UUID
    @NSManaged public var creationDate: Date
    @NSManaged public var icon: Data?
    @NSManaged public var projectDescription: String?
    @NSManaged public var projectPriority: String
    @NSManaged public var projectProgress: String
    @NSManaged public var projectTitle: String
    @NSManaged public var projectURL: URL?

}

extension Project : Identifiable {

}
