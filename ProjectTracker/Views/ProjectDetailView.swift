//
//  ProjectDetailView.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 27.04.2024.
//

// MARK: Imports
import UIKit
import WebKit

// MARK: ProjectDetailView class
final class ProjectDetailView: UIView {
    // MARK: Constants and variables
    private let project: Project
    private var regularConstraints: [NSLayoutConstraint]?
    private var compactConstraints: [NSLayoutConstraint]?
    
    // MARK: UI components
    private let projectTitleLabel: UILabel = {
        let projectTitleLabel = UILabel()
        projectTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        projectTitleLabel.font = .preferredFont(forTextStyle: .title1)
        projectTitleLabel.textAlignment = .center
        projectTitleLabel.numberOfLines = 0
        projectTitleLabel.textColor = .label
        return projectTitleLabel
    }()
    
    private let projectDescriptionLabel: UILabel = {
        let projectDescriptionLabel = UILabel()
        projectDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        projectDescriptionLabel.font = .preferredFont(forTextStyle: .body)
        projectDescriptionLabel.textAlignment = .center
        projectDescriptionLabel.numberOfLines = 0
        projectDescriptionLabel.textColor = .label
        return projectDescriptionLabel
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
    
    private let horizontalStackView: UIStackView = {
        let horizontalStackView = UIStackView()
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .equalCentering
        return horizontalStackView
    }()
    
    private let projectPriorityLabel: UILabel = {
        let projectPriorityLabel = UILabel()
        projectPriorityLabel.translatesAutoresizingMaskIntoConstraints = false
        projectPriorityLabel.font = .preferredFont(forTextStyle: .body)
        projectPriorityLabel.textAlignment = .center
        projectPriorityLabel.textColor = .label
        projectPriorityLabel.numberOfLines = 0
        return projectPriorityLabel
    }()
    
    private let projectProgressLabel: UILabel = {
        let projectProgressLabel = UILabel()
        projectProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        projectProgressLabel.font = .preferredFont(forTextStyle: .body)
        projectProgressLabel.textAlignment = .center
        projectProgressLabel.textColor = .label
        projectProgressLabel.numberOfLines = 0
        return projectProgressLabel
    }()
    
    private let projectCreationDateLabel: UILabel = {
        let projectCreationDateLabel = UILabel()
        projectCreationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        projectCreationDateLabel.font = .preferredFont(forTextStyle: .body)
        projectCreationDateLabel.textAlignment = .center
        projectCreationDateLabel.textColor = .label
        projectCreationDateLabel.numberOfLines = 0
        return projectCreationDateLabel
    }()
    
    private let projectURLLabel: UILabel = {
        let projectURLLabel = UILabel()
        projectURLLabel.translatesAutoresizingMaskIntoConstraints = false
        projectURLLabel.font = .preferredFont(forTextStyle: .body)
        projectURLLabel.textAlignment = .center
        projectURLLabel.textColor = .label
        projectURLLabel.numberOfLines = 0
        return projectURLLabel
    }()
    
    private let openURLButton: UIButton = {
        let openURLButton = UIButton()
        openURLButton.translatesAutoresizingMaskIntoConstraints = false
        openURLButton.setTitle("Open link".localized(), for: .normal)
        openURLButton.setTitleColor(.label, for: .normal)
        openURLButton.backgroundColor = .systemBackground
        openURLButton.layer.cornerRadius = 8
        openURLButton.layer.borderWidth = 0.5
        openURLButton.layer.borderColor = UIColor.label.cgColor
        openURLButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        openURLButton.accessibilityHint = "To open the link in your browser, double tap.".localized()
        return openURLButton
    }()
    
    // MARK: Inits
    init(project: Project) {
        self.project = project
        super.init(frame: .zero)
        regularConstraints = self.setConstraint(for: .regular)
        compactConstraints = self.setConstraint(for: .compact)
        addSubview(projectTitleLabel)
        addSubview(projectDescriptionLabel)
        addSubview(projectIconImageView)
        addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(projectPriorityLabel)
        horizontalStackView.addArrangedSubview(projectProgressLabel)
        horizontalStackView.addArrangedSubview(projectCreationDateLabel)
        addSubview(projectURLLabel)
        addSubview(openURLButton)
        openURLButton.addTarget(self, action: #selector(openURL), for: .touchUpInside)
        configureUI(with: project)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle functions
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        updateCGColors()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Sets constraints.
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
    
    // MARK: Functions
    /// Creates array of NSLayoutConstraint for given sizeClass parameter.
    ///
    /// - Parameters:
    ///     - sizeClass: Size class for which will be NSLayoutConstraint created.
    private func setConstraint(for sizeClass: SizeClassEnum) -> [NSLayoutConstraint] {
        switch sizeClass {
        case .regular:
            return [
                projectTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
                projectTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectDescriptionLabel.topAnchor.constraint(equalTo: projectTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectDescriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectIconImageView.topAnchor.constraint(equalTo: projectDescriptionLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectIconImageView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
                projectIconImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.4),
                projectIconImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                
                horizontalStackView.topAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                horizontalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                horizontalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                projectURLLabel.topAnchor.constraint(equalTo: horizontalStackView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectURLLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 10),
                projectURLLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10),
                
                openURLButton.topAnchor.constraint(equalTo: projectURLLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                openURLButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                openURLButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ]
        case .compact:
            return [
                projectTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
                projectTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectTitleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectDescriptionLabel.topAnchor.constraint(equalTo: projectTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectDescriptionLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectDescriptionLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectIconImageView.topAnchor.constraint(equalTo: projectDescriptionLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectIconImageView.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
                projectIconImageView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, multiplier: 0.3),
                projectIconImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                
                horizontalStackView.topAnchor.constraint(equalTo: projectIconImageView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                horizontalStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                horizontalStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                projectURLLabel.topAnchor.constraint(equalTo: horizontalStackView.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                projectURLLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                projectURLLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                
                openURLButton.topAnchor.constraint(equalTo: projectURLLabel.safeAreaLayoutGuide.bottomAnchor, constant: 20),
                openURLButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                openURLButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor)
            ]
        }
    }
    
    /// Updates CGColors.
    private func updateCGColors() {
        projectIconImageView.layer.borderColor = UIColor.label.cgColor
        openURLButton.layer.borderColor = UIColor.label.cgColor
    }
    
    /// Configures UI for selected project.
    ///
    /// - Parameters:
    ///     - project: Project for show details.
    private func configureUI(with project: Project) {
        projectTitleLabel.text = project.projectTitle
        if let projectDescription = project.projectDescription {
            if projectDescription == "" {
                projectDescriptionLabel.text = "-"
                projectDescriptionLabel.accessibilityLabel = "No description!".localized()
            }
            else {
                projectDescriptionLabel.text = "\(projectDescription)"
                projectDescriptionLabel.accessibilityLabel = "Project description: ".localized() + "\(projectDescription)"
            }
        }
        else {
            projectDescriptionLabel.text = "-"
            projectDescriptionLabel.accessibilityLabel = "No description!".localized()
        }
        
        projectIconImageView.image = UIImage(data: project.icon!)
        projectPriorityLabel.text = "Priority".localized() + "\n\(project.projectPriority.title)"
        projectPriorityLabel.accessibilityLabel = "Project priority: ".localized() + "\n\(project.projectPriority.title)"

        projectProgressLabel.text = "Progress".localized() + "\n\(project.projectProgress.title)"
        projectProgressLabel.accessibilityLabel = "Project progress: ".localized() + "\n\(project.projectProgress.title)"

        projectCreationDateLabel.text = "Creation date".localized() + "\n\(project.creationDate.formatted(date: .numeric, time: .omitted))"
        projectCreationDateLabel.accessibilityLabel = "Project creation date: ".localized() + "\n\(project.creationDate.formatted(date: .numeric, time: .omitted))"

        if project.projectURL != nil {
            projectURLLabel.text = "Project URL:".localized() + " \(project.projectURL?.absoluteString ?? "-")"
        }
        else {
            projectURLLabel.text = "No URL has been added for this project!".localized()
            openURLButton.isHidden = true
        }
    }
    
    /// Triggers a openURLButton action.
    @objc private func openURL() {
        // Opens the URL in Safari if it is possible.
        guard let projectURL = project.projectURL else {
            return
        }
        UIApplication.shared.open(projectURL)
    }
}
