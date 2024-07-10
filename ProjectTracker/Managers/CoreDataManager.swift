//
//  CoreDataManager.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

// MARK: Imports
import UIKit
import CoreData

// MARK: CoreDataManager class
final class CoreDataManager {
    // MARK: Constants and variables
    static let shared = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    // MARK: Inits
    private init() {}
    
    // MARK: Functions
    /// Adds a new object to the CoreData.
    ///
    /// - Parameters:
    ///     - object: The object which  will be added.
    public func addObject(_ object: ProjectModel) {
        let project = Project(context: context)
        project.projectID = UUID()
        project.projectTitle = object.projectTitle
        project.projectDescription = object.projectDescription
        project.projectPriority = object.projectPriority
        project.projectProgress = object.projectProgress
        project.creationDate = object.creationDate
        project.icon = object.icon
        project.projectURL = object.projectURL
        appDelegate.saveContext()
    }
    
    /// Delete a selected object from the CoreData.
    ///
    /// - Parameters:
    ///     - object: The object which  will be deleted.
    public func deleteObject(_ object: Project) {
        context.delete(object)
        appDelegate.saveContext()
    }
    
    /// Replaces the old object with a new object in the CoreData.
    ///
    /// - Parameters:
    ///     - oldObject: The object which will be replaced.
    ///     - newObject:  The object which will replaces it.
    public func replaceObject(oldObject: Project, newObject: ProjectModel) {
        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()

        let predicate = NSPredicate(format: "projectID == '\(oldObject.projectID)'")
        fetchRequest.predicate = predicate

        let fetchedObject = try? context.fetch(fetchRequest).first
        fetchedObject?.projectTitle = newObject.projectTitle
        fetchedObject?.projectDescription = newObject.projectDescription
        fetchedObject?.icon = newObject.icon
        fetchedObject?.projectPriority = newObject.projectPriority
        fetchedObject?.projectProgress = newObject.projectProgress
        fetchedObject?.projectURL = newObject.projectURL
        try? context.save()
    }
}
