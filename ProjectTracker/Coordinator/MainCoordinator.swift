//
//  MainCoordinator.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func launch()
}

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.prefersLargeTitles = true
        launch()
    }
    
    internal func launch() {
        pushProjectsViewController()
    }
    
    public func pushProjectsViewController() {
        let vc = ProjectsViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func pushAddProjectViewController() {
        let vc = AddProjectViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func pushProjectDetailViewController() {
            let vc = ProjectDetailViewController()
            vc.coordinator = self
            self.navigationController.pushViewController(vc, animated: true)
    }
    
    public func pushEditProjectViewController() {
        let vc = EditProjectViewController()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
}
