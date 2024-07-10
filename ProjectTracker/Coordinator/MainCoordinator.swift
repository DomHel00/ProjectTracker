//
//  MainCoordinator.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

// MARK: Imports
import Foundation
import UIKit

// MARK: Coordinator protocol
protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func launch()
}

// MARK: MainCoordinator class
final class MainCoordinator: Coordinator {
    // MARK: Constants and variables
    var navigationController: UINavigationController
    
    // MARK: Inits
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        launch()
    }
    
    // MARK: Functions
    /// Launchs the coordinator.
    internal func launch() {
        pushProjectsViewController()
    }
    
    /// Pushes the ProjectsViewController.
    public func pushProjectsViewController() {
        let vc = ProjectsViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    /// Pushes the AddProjectViewController.
    public func pushAddProjectViewController() {
        let vc = AddProjectViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    /// Pushes the ProjectDetailViewController.
    ///
    /// - Parameters:
    ///     - project: The project which details will be showed.
    public func pushProjectDetailViewController(project: Project) {
            let vc = ProjectDetailViewController(project: project)
            vc.coordinator = self
            self.navigationController.pushViewController(vc, animated: true)
    }
    
    /// Pushes the EditProjectViewController.
    ///
    /// - Parameters:
    ///     - project: The project which  will be edited.
    public func pushEditProjectViewController(project: Project) {
        let vc = EditProjectViewController(project: project)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    /// Pops to the ProjectsViewController.
    public func popToProjectsViewController() {
        self.navigationController.popToRootViewController(animated: true)
    }
}
