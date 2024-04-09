//
//  ProjectDetailViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

import UIKit

final class ProjectDetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "Project detail"
    }
}
