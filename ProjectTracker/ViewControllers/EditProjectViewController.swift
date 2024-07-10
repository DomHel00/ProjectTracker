//
//  EditProjectViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

// MARK: Imports
import UIKit
import PhotosUI

// MARK: EditProjectViewController class
final class EditProjectViewController: UIViewController {
    // MARK: Constants and variables
    weak var coordinator: MainCoordinator?
    
    private let project: Project
    private let databse = CoreDataManager.shared
    
    // MARK: UI components
    private let contentScrollView: UIScrollView = {
        let contentScrollView = UIScrollView()
        contentScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentScrollView.isScrollEnabled = true
        return contentScrollView
    }()
    
    private let contentFormView: AddEditFormView = {
        let contentFormView = AddEditFormView()
        contentFormView.translatesAutoresizingMaskIntoConstraints = false
        return contentFormView
    }()
    
    private let alertController: UIAlertController = {
        let alertController = UIAlertController(title: "Warning".localized(), message: "Title textfield cannot be empty!".localized(), preferredStyle: .alert)
        alertController.addAction(.init(title: "Cancel".localized(), style: .cancel))
        return alertController
    }()
    
    // MARK: Inits
    init(project: Project) {
        self.project = project
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle functions
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // Sets constraints.
        let h = contentFormView.heightAnchor.constraint(equalTo: contentScrollView.heightAnchor)
        h.isActive = true
        h.priority = UILayoutPriority(50)
        
        NSLayoutConstraint.activate([
            contentScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contentScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            contentScrollView.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -10),

            contentFormView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            contentFormView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            contentFormView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            contentFormView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            contentFormView.widthAnchor.constraint(equalTo: contentScrollView.widthAnchor)
        ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.largeTitleDisplayMode = .never
        title = "Edit project".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save".localized(), image: nil, target: self, action: #selector(didTapSaveButton))
        navigationItem.rightBarButtonItem?.accessibilityLabel = "Save changes".localized()
        navigationItem.rightBarButtonItem?.accessibilityHint = "To save your changes, double tap.".localized()

        contentFormView.configureUIEditMode(for: project)
        contentFormView.delegate = self
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentFormView)
    }
    
    // MARK: Functions
    /// Triggers action for right bar button item.
    @objc private func didTapSaveButton() {
        // Triggers creation of new project and replaces the old one with the new one if it is possible or show alert.
        if let newProject = contentFormView.createProject() {
            databse.updateObject(oldObject: project, newObject: newProject)
            coordinator?.popToProjectsViewController()
        }
        else {
            present(alertController, animated: true)
        }
    }
}
// MARK: AddEditFormViewDelegate extension
extension EditProjectViewController: AddEditFormViewDelegate {
    func didTapIconButton() {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        
        let vc = PHPickerViewController(configuration: config)
        vc.delegate = self
        present(vc, animated: true)
    }
}

// MARK: PHPickerViewControllerDelegate extension
extension EditProjectViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        results.first?.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { image, error in
            guard let image = image as? UIImage,  error == nil else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.contentFormView.updateIcon(for: image)
            }
        })
    }
}
