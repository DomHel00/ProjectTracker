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
    private var regularConstraints: [NSLayoutConstraint]?
    private var compactConstraints: [NSLayoutConstraint]?
    
    private let projectTitleLabel: UILabel = {
        let projectTitleLabel = UILabel()
        projectTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        projectTitleLabel.isAccessibilityElement = false
        projectTitleLabel.font = .preferredFont(forTextStyle: .headline)
        projectTitleLabel.textAlignment = .left
        projectTitleLabel.textColor = .label
        return projectTitleLabel
    }()
    
    private let projectTitleTextField: UITextField = {
        let projectTitleTextField = UITextField()
        projectTitleTextField.translatesAutoresizingMaskIntoConstraints = false
        projectTitleTextField.keyboardType = .alphabet
        projectTitleTextField.autocorrectionType = .no
        projectTitleTextField.layer.cornerRadius = 8
        projectTitleTextField.layer.borderWidth = 0.5
        projectTitleTextField.layer.borderColor = UIColor.label.cgColor
        return projectTitleTextField
    }()
    
    private let projectDescriptionLabel: UILabel = {
        let projectDescriptionLabel = UILabel()
        projectDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        projectDescriptionLabel.isAccessibilityElement = false
        projectDescriptionLabel.font = .preferredFont(forTextStyle: .headline)
        projectDescriptionLabel.textAlignment = .left
        projectDescriptionLabel.textColor = .label
        return projectDescriptionLabel
    }()
    
    private let projectDescriptionTextView: UITextView = {
        let projectDescriptionTextView = UITextView()
        projectDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        projectDescriptionTextView.autocorrectionType = .no
        projectDescriptionTextView.layer.cornerRadius = 8
        projectDescriptionTextView.layer.borderWidth = 0.5
        projectDescriptionTextView.layer.borderColor = UIColor.label.cgColor
        return projectDescriptionTextView
    }()
    
    private let projectIconLabel: UILabel = {
        let projectIconLabel = UILabel()
        projectIconLabel.translatesAutoresizingMaskIntoConstraints = false
        projectIconLabel.isAccessibilityElement = false
        projectIconLabel.font = .preferredFont(forTextStyle: .headline)
        projectIconLabel.textAlignment = .left
        projectIconLabel.textColor = .label
        return projectIconLabel
    }()
    
    private let projectIconImageView: UIImageView = {
        let projectIconImageView = UIImageView()
        projectIconImageView.translatesAutoresizingMaskIntoConstraints = false
        projectIconImageView.clipsToBounds = true
        projectIconImageView.contentMode = .scaleToFill
        projectIconImageView.layer.cornerRadius = 8
        projectIconImageView.layer.borderWidth = 0.5
        projectIconImageView.layer.borderColor = UIColor.label.cgColor
        return projectIconImageView
    }()
    
    private let projectIconButton: UIButton = {
        let projectIconButton = UIButton()
        projectIconButton.translatesAutoresizingMaskIntoConstraints = false
        projectIconButton.isAccessibilityElement = false
        projectIconButton.setTitleColor(.label, for: .normal)
        projectIconButton.backgroundColor = .systemBackground
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
        return projectProgressLabel
    }()
    
    private let projectProgressSegmentedControl: UISegmentedControl = {
        let projectProgressSegmentedControl = UISegmentedControl(items: ProjectProgress.allTitles)
        projectProgressSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return projectProgressSegmentedControl
    }()
    
    private let projectURLLabel: UILabel = {
        let projectURLLabel = UILabel()
        projectURLLabel.translatesAutoresizingMaskIntoConstraints = false
        projectURLLabel.isAccessibilityElement = false
        projectURLLabel.font = .preferredFont(forTextStyle: .headline)
        projectURLLabel.textAlignment = .left
        projectURLLabel.textColor = .label
        return projectURLLabel
    }()
    
    private let projectURLTextField: UITextField = {
        let projectURLTextField = UITextField()
        projectURLTextField.translatesAutoresizingMaskIntoConstraints = false
        projectURLTextField.keyboardType = .URL
        projectURLTextField.autocapitalizationType = .none
        projectURLTextField.autocorrectionType = .no
        projectURLTextField.layer.cornerRadius = 8
        projectURLTextField.layer.borderWidth = 0.5
        projectURLTextField.layer.borderColor = UIColor.label.cgColor
        return projectURLTextField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        regularConstraints = self.setConstraint(for: .regular)
        compactConstraints = self.setConstraint(for: .compact)
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
        addSubview(projectURLLabel)
        addSubview(projectURLTextField)
        projectIconButton.addTarget(self, action: #selector(showPhotoPicker), for: .touchUpInside)
        addToolbarToKeyboard()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTextFieldPlaceholdersForVoiceOver), name: UIAccessibility.voiceOverStatusDidChangeNotification, object: nil)
        projectTitleTextField.delegate = self
        projectURLTextField.delegate = self
        projectDescriptionTextView.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateCGColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch (traitCollection.verticalSizeClass) {
        case .regular:
            NSLayoutConstraint.deactivate(compactConstraints!)
            NSLayoutConstraint.activate(regularConstraints!)
        case .compact:
            NSLayoutConstraint.deactivate(regularConstraints!)
            NSLayoutConstraint.activate(compactConstraints!)
        default:
            break
        }
    }
    
    @objc private func updateTextFieldPlaceholdersForVoiceOver() {
        if UIAccessibility.isVoiceOverRunning {
            projectTitleTextField.placeholder = nil
            projectURLTextField.placeholder = nil
        }
        else {
            projectTitleTextField.placeholder = projectTitleTextField.accessibilityLabel
            projectURLTextField.placeholder = projectURLTextField.accessibilityLabel
        }
    }
    
    private func setConstraint(for sizeClass: SizeClassEnum) -> [NSLayoutConstraint] {
        switch sizeClass {
        case .regular:
            return [
                projectTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
                projectTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectTitleTextField.topAnchor.constraint(equalTo: projectTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectTitleTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectTitleTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                projectTitleTextField.heightAnchor.constraint(equalToConstant: 30),
                
                projectDescriptionLabel.topAnchor.constraint(equalTo: projectTitleTextField.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectDescriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectDescriptionTextView.topAnchor.constraint(equalTo: projectDescriptionLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectDescriptionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectDescriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                projectDescriptionTextView.heightAnchor.constraint(equalToConstant: 150),
                
                projectIconLabel.topAnchor.constraint(equalTo: projectDescriptionTextView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectIconLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectIconLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectIconImageView.topAnchor.constraint(equalTo: projectIconLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectIconImageView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
                projectIconImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.5),
                projectIconImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                
                projectIconButton.topAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectIconButton.widthAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.widthAnchor),
                projectIconButton.centerXAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.centerXAnchor),
                
                projectPriorityLabel.topAnchor.constraint(equalTo: projectIconButton.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectPriorityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectPriorityLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectPrioritySegmentedControl.topAnchor.constraint(equalTo: projectPriorityLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectPrioritySegmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectPrioritySegmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectProgressLabel.topAnchor.constraint(equalTo: projectPrioritySegmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectProgressLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectProgressLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectProgressSegmentedControl.topAnchor.constraint(equalTo: projectProgressLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectProgressSegmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectProgressSegmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectURLLabel.topAnchor.constraint(equalTo: projectProgressSegmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectURLLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectURLLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectURLTextField.topAnchor.constraint(equalTo: projectURLLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectURLTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectURLTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                projectURLTextField.heightAnchor.constraint(equalToConstant: 30),
                projectURLTextField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            ]
        case .compact:
            return [
                projectTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
                projectTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectTitleTextField.topAnchor.constraint(equalTo: projectTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectTitleTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectTitleTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                projectTitleTextField.heightAnchor.constraint(equalToConstant: 30),
                
                projectDescriptionLabel.topAnchor.constraint(equalTo: projectTitleTextField.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectDescriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectDescriptionTextView.topAnchor.constraint(equalTo: projectDescriptionLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectDescriptionTextView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectDescriptionTextView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                projectDescriptionTextView.heightAnchor.constraint(equalToConstant: 150),
                
                projectIconLabel.topAnchor.constraint(equalTo: projectDescriptionTextView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectIconLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectIconLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectIconImageView.topAnchor.constraint(equalTo: projectIconLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectIconImageView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
                projectIconImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
                projectIconImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                
                projectIconButton.topAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectIconButton.widthAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.widthAnchor),
                projectIconButton.centerXAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.centerXAnchor),
                
                projectPriorityLabel.topAnchor.constraint(equalTo: projectIconButton.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectPriorityLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectPriorityLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectPrioritySegmentedControl.topAnchor.constraint(equalTo: projectPriorityLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectPrioritySegmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectPrioritySegmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectProgressLabel.topAnchor.constraint(equalTo: projectPrioritySegmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectProgressLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectProgressLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectProgressSegmentedControl.topAnchor.constraint(equalTo: projectProgressLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectProgressSegmentedControl.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectProgressSegmentedControl.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectURLLabel.topAnchor.constraint(equalTo: projectProgressSegmentedControl.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectURLLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectURLLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectURLTextField.topAnchor.constraint(equalTo: projectURLLabel.safeAreaLayoutGuide.bottomAnchor, constant: 10),
                projectURLTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectURLTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                projectURLTextField.heightAnchor.constraint(equalToConstant: 30),
                projectURLTextField.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -10)
            ]
        }
    }
    
    private func updateCGColors() {
        projectTitleTextField.layer.borderColor = UIColor.label.cgColor
        projectDescriptionTextView.layer.borderColor = UIColor.label.cgColor
        projectIconImageView.layer.borderColor = UIColor.label.cgColor
        projectIconButton.layer.borderColor = UIColor.label.cgColor
        projectURLTextField.layer.borderColor = UIColor.label.cgColor
    }
    
    @objc private func showPhotoPicker() {
        delegate?.didTapIconButton()
    }
    
    public func updateIcon(for image: UIImage) {
        self.projectIconImageView.image = image
    }
    
    public func configureUIAddMode() {
        projectTitleLabel.text = "Set project title".localized()
        
        projectTitleTextField.placeholder = "Set project title".localized()
        projectTitleTextField.accessibilityLabel = "Set project title".localized()
        
        projectDescriptionLabel.text = "Set project description (optional)".localized()
        
        projectDescriptionTextView.accessibilityLabel = "Set project description (optional)".localized()

        projectIconLabel.text = "Set project icon (optional)".localized()
        
        projectIconImageView.image = UIImage(named: "icon")
        
        projectIconButton.setTitle("Set project icon".localized(), for: .normal)
        
        projectPriorityLabel.text = "Set project priority".localized()
        
        projectPrioritySegmentedControl.selectedSegmentIndex = 0
        
        projectProgressLabel.text = "Set project progress".localized()
        
        projectProgressSegmentedControl.selectedSegmentIndex = 0
        
        projectURLLabel.text = "Set project URL (optional)".localized()
        
        projectURLTextField.placeholder = "Set project URL (optional)".localized()
        projectURLTextField.accessibilityLabel = "Set project URL (optional)".localized()
        
        updateTextFieldPlaceholdersForVoiceOver()
    }
    
    public func configureUIEditMode(for project: Project) {
        projectTitleLabel.text = "Edit project title".localized()
        
        projectTitleTextField.text = project.projectTitle
        projectTitleTextField.placeholder = "Edit project title".localized()
        projectTitleTextField.accessibilityLabel = "Edit project title".localized()
        projectTitleTextField.accessibilityValue = project.projectTitle
        
        projectDescriptionLabel.text = "Edit project description (optional)".localized()
        
        projectDescriptionTextView.text = project.projectDescription
        projectDescriptionTextView.accessibilityLabel = "Edit project description (optional)".localized()
        projectDescriptionTextView.accessibilityValue = project.projectDescription

        projectIconLabel.text = "Edit project icon (optional)".localized()
        
        if let savedImage = project.icon {
            projectIconImageView.image = UIImage(data: savedImage)
        }
        else {
            projectIconImageView.image = UIImage(named: "icon")
        }
        
        projectIconButton.setTitle("Edit project icon".localized(), for: .normal)
        
        projectPriorityLabel.text = "Edit project priority".localized()
        
        projectPrioritySegmentedControl.selectedSegmentIndex = Int(project.projectPriorityIndex)
        
        projectProgressLabel.text = "Edit project progress".localized()
        
        projectProgressSegmentedControl.selectedSegmentIndex = Int(project.projectProgressIndex)
        
        projectURLLabel.text = "Edit project URL (optional)".localized()
        
        projectURLTextField.placeholder = "Edit project URL".localized()
        projectURLTextField.accessibilityLabel = "Edit project URL (optional)".localized()

        if let savedURL = project.projectURL {
            projectURLTextField.text = savedURL.absoluteString
            projectURLTextField.accessibilityValue = savedURL.absoluteString
        }
        
        updateTextFieldPlaceholdersForVoiceOver()
    }
    
    public func createProject() -> ProjectModel? {
        guard let titleText = projectTitleTextField.text else {
            return nil
        }
        
        let trimmedTitleText = titleText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if trimmedTitleText.isEmpty || trimmedTitleText == "" {
            return nil
        }
        
        if let urlString = projectURLTextField.text {
            if urlString.isValidURL {
                let projectURL = URL(string: urlString)
                return ProjectModel(projectTitle: trimmedTitleText, projectDescription: projectDescriptionTextView.text, projectPriority: ProjectPriority(rawValue: projectPrioritySegmentedControl.selectedSegmentIndex) ?? .none, projectProgress: ProjectProgress(rawValue: projectProgressSegmentedControl.selectedSegmentIndex) ?? .initialization, creationDate: .now, icon: projectIconImageView.image?.pngData(), projectURL: projectURL)
            }
            else {
                
                return ProjectModel(projectTitle: trimmedTitleText, projectDescription: projectDescriptionTextView.text, projectPriority: ProjectPriority(rawValue: projectPrioritySegmentedControl.selectedSegmentIndex) ?? .none, projectProgress: ProjectProgress(rawValue: projectProgressSegmentedControl.selectedSegmentIndex) ?? .initialization, creationDate: .now, icon: projectIconImageView.image?.pngData(), projectURL: nil)
            }
        }
        else {
            return ProjectModel(projectTitle: trimmedTitleText, projectDescription: projectDescriptionTextView.text, projectPriority: ProjectPriority(rawValue: projectPrioritySegmentedControl.selectedSegmentIndex) ?? .none, projectProgress: ProjectProgress(rawValue: projectProgressSegmentedControl.selectedSegmentIndex) ?? .initialization, creationDate: .now, icon: projectIconImageView.image?.pngData(), projectURL: nil)
        }
    }
    
    private func addToolbarToKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let btnDoneOnKeyboard = UIBarButtonItem(title: "Done".localized(), style: .done, target: self, action: #selector(hideKeyboard))
        let btnClearOnKeyboard = UIBarButtonItem(title: "Clear".localized(), style: .plain, target: self, action: #selector(clearTextField))
        btnClearOnKeyboard.tintColor = .systemRed
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        btnDoneOnKeyboard.accessibilityHint = "To stop editing and hide the keyboard, double tap.".localized()
        btnClearOnKeyboard.accessibilityHint = "To delete text in the field, double tap.".localized()
        
        toolbar.items = [btnClearOnKeyboard, flexSpace, btnDoneOnKeyboard]
        
        projectTitleTextField.inputAccessoryView = toolbar
        projectDescriptionTextView.inputAccessoryView = toolbar
        projectURLTextField.inputAccessoryView = toolbar
    }
    
    @objc private func hideKeyboard() {
        if projectTitleTextField.isFirstResponder {
            projectTitleTextField.resignFirstResponder()
        }
        else if projectDescriptionTextView.isFirstResponder {
            projectDescriptionTextView.resignFirstResponder()
        }
        else if projectURLTextField.isFirstResponder {
            projectURLTextField.resignFirstResponder()
        }
    }
    
    @objc private func clearTextField() {
        if projectTitleTextField.isFirstResponder {
            projectTitleTextField.text = nil
        }
        else if projectDescriptionTextView.isFirstResponder {
            projectDescriptionTextView.text = nil
        }
        else if projectURLTextField.isFirstResponder {
            projectURLTextField.text = nil
        }
    }
}

extension AddEditFormView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if projectTitleTextField.isFirstResponder {
            projectTitleTextField.accessibilityValue = textField.text
        }
        
        if projectURLTextField.isFirstResponder {
            projectURLTextField.accessibilityValue = textField.text
        }
    }
    
}

extension AddEditFormView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        projectDescriptionTextView.accessibilityValue = textView.text
    }
}
