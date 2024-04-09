//
//  AddProjectViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

import UIKit

final class AddProjectViewController: UIViewController {
    weak var coordinator: MainCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        title = "Add new project"
    }
}
