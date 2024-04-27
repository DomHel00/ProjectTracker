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
    
    private let database = CoreDataManager.shared
    
    private let projectsTableView: UITableView = {
        let projectsTableView = UITableView()
        projectsTableView.translatesAutoresizingMaskIntoConstraints = false
        projectsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return projectsTableView
    }()
    
    private let noProjectsTableViewDataVIew: NoProjectsTableViewDataVIew = {
        let noProjectsTableViewDataVIew = NoProjectsTableViewDataVIew()
        noProjectsTableViewDataVIew.translatesAutoresizingMaskIntoConstraints = false
        noProjectsTableViewDataVIew.layer.cornerRadius = 10
        noProjectsTableViewDataVIew.layer.borderColor = UIColor.secondaryLabel.cgColor
        noProjectsTableViewDataVIew.layer.borderWidth = 1
        return noProjectsTableViewDataVIew
    }()
    
    @objc private func didTapRightBarButtonItem() {
        DispatchQueue.main.async { [weak self] in
            self?.coordinator?.pushAddProjectViewController()
        }
    }
    
    @objc private func didTapLeftBarButtonItem() {
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        NSLayoutConstraint.activate([
            projectsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            projectsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            projectsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            projectsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        if database.fetchController.fetchedObjects?.count == 0 {
            NSLayoutConstraint.activate([
                noProjectsTableViewDataVIew.heightAnchor.constraint(equalTo: projectsTableView.widthAnchor, multiplier: 0.4),
                noProjectsTableViewDataVIew.widthAnchor.constraint(equalTo: projectsTableView.widthAnchor, multiplier: 0.4),
                noProjectsTableViewDataVIew.centerXAnchor.constraint(equalTo: projectsTableView.centerXAnchor),
                noProjectsTableViewDataVIew.centerYAnchor.constraint(equalTo: projectsTableView.centerYAnchor)
            ])
        }
        else {
            NSLayoutConstraint.deactivate([
                noProjectsTableViewDataVIew.heightAnchor.constraint(equalTo: projectsTableView.widthAnchor, multiplier: 0.4),
                noProjectsTableViewDataVIew.widthAnchor.constraint(equalTo: projectsTableView.widthAnchor, multiplier: 0.4),
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
        
        database.fetchController.delegate = self
        
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
        
        view.addSubview(projectsTableView)
    }
}

extension ProjectsViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        print("1")
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        print("2")
        
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith snapshot: NSDiffableDataSourceSnapshotReference) {
        print("3")
        DispatchQueue.main.async { [weak self] in
            self?.projectsTableView.reloadData()
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChangeContentWith diff: CollectionDifference<NSManagedObjectID>) {
        print("4")
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange sectionInfo: any NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        print("5")
        switch type {
            
        case .insert:
            print("přidávám")
        case .delete:
            print("mažu")
        case .move:
            print("movuju")
        case .update:
            print("updatuju")
        @unknown default:
            print("nic")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        print("6")
        
        switch type {
            
        case .insert:
            print("přidávám2")
        case .delete:
            print("mažu2")
        case .move:
            print("movuju")
        case .update:
            print("updatuju")
        @unknown default:
            print("nic")
        }
    }
}

extension ProjectsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if database.fetchController.fetchedObjects?.count == 0 {
            tableView.backgroundView = noProjectsTableViewDataVIew
        }
        else {
            tableView.backgroundView = nil
        }
        
        return database.fetchController.fetchedObjects?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = database.fetchController.fetchedObjects?[indexPath.row].projectTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let selectedProject = database.fetchController.object(at: indexPath)
        
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
}
