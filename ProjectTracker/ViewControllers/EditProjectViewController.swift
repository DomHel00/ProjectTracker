//
//  EditProjectViewController.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 09.04.2024.
//

import UIKit
import PhotosUI
final class EditProjectViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    
    private let project: Project
    private let databse = CoreDataManager.shared
    
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
        let alertController = UIAlertController(title: "Error", message: "Title connot be empty!", preferredStyle: .alert)
        alertController.addAction(.init(title: "Cancel", style: .cancel))
        return alertController
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
        title = "Edit project"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", image: nil, target: self, action: #selector(didTapSaveButton))
        
        contentFormView.configureUIEditMode(for: project)
        contentFormView.delegate = self
        
        view.addSubview(contentScrollView)
        contentScrollView.addSubview(contentFormView)
    }
    
    @objc private func didTapSaveButton() {
        if let newProject = contentFormView.createProject() {
            // TODO: Update project
            databse.updateObject(oldObject: project, newObject: newProject)
            coordinator?.popToProjectsViewController()
        }
        else {
            present(alertController, animated: true)
        }
    }
}

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
