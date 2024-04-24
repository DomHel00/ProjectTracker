//
//  Project+CoreDataProperties.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//
//

import Foundation
import CoreData


extension Project {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }

    @NSManaged public var icon: Data?
    @NSManaged public var creationDate: Date?
    @NSManaged public var projectProgress: String?
    @NSManaged public var projectPriority: String?
    @NSManaged public var projectDescription: String?
    @NSManaged public var projectTitle: String?

}

extension Project : Identifiable {

}
