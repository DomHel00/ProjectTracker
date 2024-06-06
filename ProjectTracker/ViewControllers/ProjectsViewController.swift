//
//  ProjectsViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 07.04.2024.
//

import UIKit
import CoreData

final class ProjectsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private var fetchController: NSFetchedResultsController<Project>!
    private let database = CoreDataManager.shared

    private var searchText: String? {
        didSet {
            initFetchController(sortType: "", filterString: searchText)
        }
    }
    
    private let projectsTableView: UITableView = {
        let projectsTableView = UITableView()
        projectsTableView.translatesAutoresizingMaskIntoConstraints = false
        projectsTableView.register(ProjectTableViewCell.self, forCellReuseIdentifier: ProjectTableViewCell.identifier)
        return projectsTableView
    }()
    
    private let noProjectsTableViewDataVIew: NoProjectsTableViewDataVIew = {
        let noProjectsTableViewDataVIew = NoProjectsTableViewDataVIew()
        noProjectsTableViewDataVIew.translatesAutoresizingMaskIntoConstraints = false
        noProjectsTableViewDataVIew.layer.cornerRadius = 10
        return noProjectsTableViewDataVIew
    }()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search..."
        searchBar.sizeToFit()
        return searchBar
    }()
    
    override func viewDidDisappear(_ animated: Bool) {
        searchText = nil
        searchBar.text = nil
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        NSLayoutConstraint.activate([
            projectsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        
        var noProjectsTableViewDataVIewSize: CGFloat = 0
        
        switch (traitCollection.verticalSizeClass) {
        case .regular:
            noProjectsTableViewDataVIewSize = (view.frame.size.width * 0.3)
            break
        case .compact:
            noProjectsTableViewDataVIewSize = (view.frame.size.width * 0.15)
            break
        default:
            break
        }
        
        if fetchController.fetchedObjects?.count == 0 {
            NSLayoutConstraint.activate([
                noProjectsTableViewDataVIew.heightAnchor.constraint(equalToConstant: noProjectsTableViewDataVIewSize),
                noProjectsTableViewDataVIew.widthAnchor.constraint(equalToConstant: noProjectsTableViewDataVIewSize),
                noProjectsTableViewDataVIew.centerXAnchor.constraint(equalTo: projectsTableView.centerXAnchor),
                noProjectsTableViewDataVIew.centerYAnchor.constraint(equalTo: projectsTableView.centerYAnchor)
            ])
        }
        else {
            NSLayoutConstraint.deactivate([
                noProjectsTableViewDataVIew.heightAnchor.constraint(equalToConstant:noProjectsTableViewDataVIewSize),
                noProjectsTableViewDataVIew.widthAnchor.constraint(equalToConstant: noProjectsTableViewDataVIewSize),
                noProjectsTableViewDataVIew.centerXAnchor.constraint(equalTo: projectsTableView.centerXAnchor),
                noProjectsTableViewDataVIew.centerYAnchor.constraint(equalTo: projectsTableView.centerYAnchor)
            ])
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .always
        title = "My projects"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add new project", image: UIImage(systemName: "plus"), target: self, action: #selector(didTapRightBarButtonItem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Select sort type", image: UIImage(systemName: "arrow.up.arrow.down"), target: self, action: #selector(didTapLeftBarButtonItem))
        
        initFetchController(sortType: "", filterString: searchText)

        projectsTableView.tableHeaderView = searchBar
        
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        searchBar.delegate = self

        view.addSubview(projectsTableView)
    }
    
    @objc private func didTapRightBarButtonItem() {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.pushAddProjectViewController()
        }
    }
    
    @objc private func didTapLeftBarButtonItem() {
        
    }
    
    private func initFetchController(sortType: String, filterString: String?) {
        let request = Project.fetchRequest() as NSFetchRequest<Project>
        let titleSort = NSSortDescriptor(key: #keyPath(Project.projectTitle), ascending: true)
        let dateSort = NSSortDescriptor(key: #keyPath(Project.creationDate), ascending: true)

        request.sortDescriptors = [titleSort, dateSort]
        if let filterString = filterString {
            if filterString != "" {
                request.predicate = NSPredicate(format: "projectTitle CONTAINS[c] %@", filterString)
            }
        }
        
        do {
            fetchController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: database.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchController.delegate = self
            try fetchController.performFetch()
        }
        catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}

extension ProjectsViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        DispatchQueue.main.async { [weak self] in
            self?.projectsTableView.reloadData()
        }
    }
}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchController.fetchedObjects?.count == 0 {
            tableView.backgroundView = noProjectsTableViewDataVIew
        }
        else {
            tableView.backgroundView = nil
        }
        return fetchController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProjectTableViewCell.identifier, for: indexPath) as? ProjectTableViewCell else {
            return UITableViewCell()
        }
        
        let project = fetchController.object(at: indexPath)
        cell.configureUI(with: project)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedProject = fetchController.object(at: indexPath)
        coordinator?.pushProjectDetailViewController(project: selectedProject)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedProject = fetchController.object(at: indexPath)
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] action, view, completion in
            self?.database.deleteObject(selectedProject)
            completion(true)
        }
        
        let editAction = UIContextualAction(style: .normal, title: "Edit") { [weak self] action, view, completion in
            self?.coordinator?.pushEditProjectViewController(project: selectedProject)
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (traitCollection.verticalSizeClass) {
        case .regular:
            return (view.frame.size.width * 0.3)
        case .compact:
            return (view.frame.size.width * 0.15)
        default:
            return 0
        }
    }
}

extension ProjectsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText = searchText
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
