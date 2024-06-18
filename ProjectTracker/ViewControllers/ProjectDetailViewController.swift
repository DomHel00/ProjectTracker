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
    
    private let projectDetailView: ProjectDetailView
        
    private let contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView()
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.isScrollEnabled = true
        return contentScrollView
    }()
    
    init(project: Project) {
        self.project = project
        self.projectDetailView = ProjectDetailView(project: project)
        projectDetailView.translatesAutoresizingMaskIntoConstraints = false
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let h = projectDetailView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor)
        h.isActive = true
        h.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),

            projectDetailView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            projectDetailView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            projectDetailView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            projectDetailView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            projectDetailView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Project detail".localized()
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(projectDetailView)
    }
}
