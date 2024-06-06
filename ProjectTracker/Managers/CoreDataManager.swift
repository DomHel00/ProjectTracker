//
//  CoreDataManager.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import UIKit
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    private init() {}
    
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
    
    public func deleteObject(_ object: Project) {
        context.delete(object)
        appDelegate.saveContext()
    }
    
    public func updateObject(oldObject: Project, newObject: ProjectModel) {
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
