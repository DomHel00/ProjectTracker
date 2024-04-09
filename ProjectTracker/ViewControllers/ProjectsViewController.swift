//
//  ProjectsViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 07.04.2024.
//

import UIKit

final class ProjectsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        title = "My projects"
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 222, height: 222))
        v.backgroundColor = .red
        v.center = view.center
        view.addSubview(v)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.coordinator?.pushProjectDetailViewController()
        }
    }
}

