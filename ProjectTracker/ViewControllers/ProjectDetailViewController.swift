//
//  ProjectDetailViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

import UIKit

final class ProjectDetailViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    private let project: Project
    
    private let detailView: ProjectDetailView = {
        let detailVIew = ProjectDetailView()
        detailVIew.translatesAutoresizingMaskIntoConstraints = false
        return detailVIew
    }()
    
    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Project detail"
        
        view.addSubview(detailView)
        detailView.configure(with: project)
    }
}
