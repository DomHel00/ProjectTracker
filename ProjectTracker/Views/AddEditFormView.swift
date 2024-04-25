//
//  AddEditFormView.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 23.04.2024.
//

import UIKit

protocol AddEditFormViewDelegate: AnyObject {
    func didTapIconButton()
}
    
final class AddEditFormView: UIView {
    public weak var delegate: AddEditFormViewDelegate?
    
    private let projectTitleLabel: UILabel = {
        let projectTitleLabel = UILabel()
        projectTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        projectTitleLabel.font = .preferredFont(forTextStyle: .headline)
        projectTitleLabel.textAlignment = .left
        projectTitleLabel.textColor = .label
        projectTitleLabel.backgroundColor = .systemFill
        return projectTitleLabel
    }()
    
    private let projectTitleTextField: UITextField = {
        let projectTitleTextField = UITextField()
        projectTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        projectTitleTextField.layer.cornerRadius = 8
        projectTitleTextField.layer.borderWidth = 0.5
        projectTitleTextField.layer.borderColor = UIColor.label.cgColor
        return projectTitleTextField
    }()
    
    private let projectDescriptionLabel: UILabel = {
        let projectDescriptionLabel = UILabel()
        projectDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        projectDescriptionLabel.font = .preferredFont(forTextStyle: .headline)
        projectDescriptionLabel.textAlignment = .left
        projectDescriptionLabel.textColor = .label
        projectDescriptionLabel.backgroundColor = .systemFill
        return projectDescriptionLabel
    }()
    
    private let projectDescriptionTextView: UITextView = {
        let projectDescriptionTextView = UITextView()
        projectDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        projectDescriptionTextView.layer.cornerRadius = 8
        projectDescriptionTextView.layer.borderWidth = 0.5
        projectDescriptionTextView.layer.borderColor = UIColor.label.cgColor
        return projectDescriptionTextView
    }()
    
    private let projectIconLabel: UILabel = {
        let projectIconLabel = UILabel()
        projectIconLabel.translatesAutoresizingMaskIntoConstraints = false
        projectIconLabel.font = .preferredFont(forTextStyle: .headline)
        projectIconLabel.textAlignment = .left
        projectIconLabel.textColor = .label
        projectIconLabel.backgroundColor = .systemFill
        return projectIconLabel
    }()
    
    private let projectIconImageView: UIImageView = {
        let projectIconImageView = UIImageView()
        projectIconImageView.translatesAutoresizingMaskIntoConstraints = false
        projectIconImageView.contentMode = .scaleToFill
        projectIconImageView.layer.cornerRadius = 8
        projectIconImageView.layer.borderWidth = 0.5
        projectIconImageView.layer.borderColor = UIColor.label.cgColor
        return projectIconImageView
    }()
    
    private let projectIconButton: UIButton = {
        let projectIconButton = UIButton()
        projectIconButton.translatesAutoresizingMaskIntoConstraints = false
        projectIconButton.setTitleColor(.label, for: .normal)
        projectIconButton.backgroundColor = .quaternarySystemFill
        projectIconButton.layer.cornerRadius = 8
        projectIconButton.layer.borderWidth = 0.5
        projectIconButton.layer.borderColor = UIColor.label.cgColor
        return projectIconButton
    }()
    
    private let projectPriorityLabel: UILabel = {
        let projectPriorityLabel = UILabel()
        projectPriorityLabel.translatesAutoresizingMaskIntoConstraints = false
        projectPriorityLabel.font = .preferredFont(forTextStyle: .headline)
        projectPriorityLabel.textAlignment = .left
        projectPriorityLabel.textColor = .label
        projectPriorityLabel.backgroundColor = .systemFill
        return projectPriorityLabel
    }()
    
    private let projectPrioritySegmentedControl: UISegmentedControl = {
        let projectPrioritySegmentedControl = UISegmentedControl(items: ProjectPriority.allTitles)
        projectPrioritySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return projectPrioritySegmentedControl
    }()
    
    private let projectProgressLabel: UILabel = {
        let projectProgressLabel = UILabel()
        projectProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        projectProgressLabel.font = .preferredFont(forTextStyle: .headline)
        projectProgressLabel.textAlignment = .left
        projectProgressLabel.textColor = .label
        projectProgressLabel.backgroundColor = .systemFill
        return projectProgressLabel
    }()
    
    private let projectProgressSegmentedControl: UISegmentedControl = {
        let projectProgressSegmentedControl = UISegmentedControl(items: ProjectProgress.allTitles)
        projectProgressSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return projectProgressSegmentedControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(projectTitleLabel)
        addSubview(projectTitleTextField)
        addSubview(projectDescriptionLabel)
        addSubview(projectDescriptionTextView)
        addSubview(projectIconLabel)
        addSubview(projectIconImageView)
        addSubview(projectIconButton)
        addSubview(projectPriorityLabel)
        addSubview(projectPrioritySegmentedControl)
        addSubview(projectProgressLabel)
        addSubview(projectProgressSegmentedControl)
        projectIconButton.addTarget(self, action: #selector(showPhotoPciker), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            projectTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            projectTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            projectTitleTextField.topAnchor.constraint(equalTo: projectTitleLabel.bottomAnchor, constant: 10),
            projectTitleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectTitleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            projectTitleTextField.heightAnchor.constraint(equalToConstant: 30),
            
            projectDescriptionLabel.topAnchor.constraint(equalTo: projectTitleTextField.bottomAnchor, constant: 20),
            projectDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            projectDescriptionTextView.topAnchor.constraint(equalTo: projectDescriptionLabel.bottomAnchor, constant: 10),
            projectDescriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectDescriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            projectDescriptionTextView.heightAnchor.constraint(equalToConstant: 150),
            
            projectIconLabel.topAnchor.constraint(equalTo: projectDescriptionTextView.bottomAnchor, constant: 20),
            projectIconLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectIconLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            projectIconImageView.topAnchor.constraint(equalTo: projectIconLabel.bottomAnchor, constant: 10),
            projectIconImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            projectIconImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            projectIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            projectIconButton.topAnchor.constraint(equalTo: projectIconImageView.bottomAnchor, constant: 10),
            projectIconButton.widthAnchor.constraint(equalTo: projectIconImageView.widthAnchor),
            projectIconButton.centerXAnchor.constraint(equalTo: projectIconImageView.centerXAnchor),
            
            projectPriorityLabel.topAnchor.constraint(equalTo: projectIconButton.bottomAnchor, constant: 20),
            projectPriorityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectPriorityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            projectPrioritySegmentedControl.topAnchor.constraint(equalTo: projectPriorityLabel.bottomAnchor, constant: 10),
            projectPrioritySegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectPrioritySegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            projectProgressLabel.topAnchor.constraint(equalTo: projectPrioritySegmentedControl.bottomAnchor, constant: 20),
            projectProgressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectProgressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            projectProgressSegmentedControl.topAnchor.constraint(equalTo: projectProgressLabel.bottomAnchor, constant: 10),
            projectProgressSegmentedControl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectProgressSegmentedControl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            projectProgressSegmentedControl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    @objc private func showPhotoPciker() {
        delegate?.didTapIconButton()
    }
    
    public func updateIcon(for image: UIImage) {
        self.projectIconImageView.image = image
    }
    
    public func AddFormUI() {
        projectTitleLabel.text = "Set project title"
        projectTitleTextField.placeholder = "Set project title"
        projectDescriptionLabel.text = "Set project description"
        projectIconLabel.text = "Set project icon"
        projectIconImageView.image = UIImage(named: "icon")
        projectIconButton.setTitle("Set project icon", for: .normal)
        projectPriorityLabel.text = "Set project priority"
        projectPrioritySegmentedControl.selectedSegmentIndex = 0
        projectProgressLabel.text = "Set project progress"
        projectProgressSegmentedControl.selectedSegmentIndex = 0
    }
    
    public func EditFormUI(for project: Project) {
        projectTitleLabel.text = "Edit project title"
        projectTitleTextField.placeholder = "Edit project title"
        projectDescriptionLabel.text = "Edit project description"
        projectIconLabel.text = "Edit project icon"
        projectTitleTextField.text = project.projectTitle
        projectDescriptionTextView.text = project.projectDescription
        if let savedImage = project.icon {
            projectIconImageView.image = UIImage(data: savedImage)
        }
        else {
            projectIconImageView.image = UIImage(named: "icon")
        }

        projectIconButton.setTitle("Edit project icon", for: .normal)
        projectPriorityLabel.text = "Edit project priority"
        
        if let savedPriority = project.projectPriority {
            let index = ProjectPriority.allTitles.firstIndex(of: savedPriority) ?? 0
            projectPrioritySegmentedControl.selectedSegmentIndex = index        }
        else {
            projectPrioritySegmentedControl.selectedSegmentIndex = 0
        }
                
        projectProgressLabel.text = "Edit project progress"
        
        if let savedProgress = project.projectProgress {
            let index = ProjectProgress.allTitles.firstIndex(of: savedProgress) ?? 0
            projectProgressSegmentedControl.selectedSegmentIndex = index
        }
        else {
            projectProgressSegmentedControl.selectedSegmentIndex = 0
        }   
    }
    
    public func createProject() -> ProjectModel? {
        guard let titleText = projectTitleTextField.text else {
            return nil
        }
        
        let trimmedTitleText = titleText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedTitleText.isEmpty || trimmedTitleText == "" {
            return nil
        }
        
        return ProjectModel(projectTitle: trimmedTitleText, projectDescription: projectDescriptionTextView.text, projectPriority: ProjectPriority.allTitles[projectPrioritySegmentedControl.selectedSegmentIndex], projectProgress: ProjectProgress.allTitles[projectProgressSegmentedControl.selectedSegmentIndex], creationDate: .now, icon: projectIconImageView.image?.pngData())
    }
}
