//
//  Project+CoreDataProperties.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 17.06.2024.
//
//

// MARK: Imports
import Foundation
import CoreData


// MARK: Project class extension
extension Project {
    // MARK: FetchRequest
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Project> {
        return NSFetchRequest<Project>(entityName: "Project")
    }
    
    // MARK: @NSManaged variables
    @NSManaged public var projectID: UUID
    @NSManaged public var creationDate: Date
    @NSManaged public var icon: Data?
    @NSManaged public var projectDescription: String?
    @NSManaged public var projectPriorityIndex: Int64
    @NSManaged public var projectProgressIndex: Int64
    @NSManaged public var projectTitle: String
    @NSManaged public var projectURL: URL?
    
    // MARK: Computed properties
    var projectPriority: ProjectPriority {
        get {
            return ProjectPriority(rawValue: Int(projectPriorityIndex)) ?? .none
        }
        set {
            projectPriorityIndex = Int64(newValue.rawValue)
        }
    }
    
    var projectProgress: ProjectProgress {
        get {
            return ProjectProgress(rawValue: Int(projectProgressIndex)) ?? .initialization
        }
        set {
            projectProgressIndex = Int64(newValue.rawValue)
        }
    }
}

extension Project : Identifiable {}
