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
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    public var fetchController: NSFetchedResultsController<Project>!
    
    private init() {
        initFetchController(sortType: "")
    }
    
    private func initFetchController(sortType: String) {
        let request = Project.fetchRequest() as NSFetchRequest<Project>
        let sort = NSSortDescriptor(key: #keyPath(Project.projectTitle), ascending: true)
        
        request.sortDescriptors = [sort]
        
        do {
            fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            try fetchController.performFetch()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    public func addObject(_ object: ProjectModel) {
        let project = Project(context: context)
        project.projectTitle = object.projectTitle
        project.projectDescription = object.projectDescription
        project.projectPriority = object.projectPriority
        project.projectProgress = object.projectProgress
        project.creationDate = object.creationDate
        project.icon = object.icon
        appDelegate.saveContext()
    }
    
    public func deleteObject(_ object: Project) {
        context.delete(object)
        appDelegate.saveContext()
    }
    
    public func updateObject(oldObject: Project, newObject: Project) {
        
    }
}
