//
//  ProjectDetailView.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 27.04.2024.
//

import UIKit

final class ProjectDetailView: UIView {
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
        projectIconImageView.contentMode = .scaleToFill
        projectIconImageView.layer.cornerRadius = 8
        return projectIconImageView
    }()
    
    private let projectPriorityLabel: UILabel = {
        let projectPriorityLabel = UILabel()
        projectPriorityLabel.translatesAutoresizingMaskIntoConstraints = false
        projectPriorityLabel.font = .preferredFont(forTextStyle: .body)
        projectPriorityLabel.textAlignment = .center
        projectPriorityLabel.textColor = .label
        return projectPriorityLabel
    }()
    
    private let projectProgressLabel: UILabel = {
        let projectProgressLabel = UILabel()
        projectProgressLabel.translatesAutoresizingMaskIntoConstraints = false
        projectProgressLabel.font = .preferredFont(forTextStyle: .body)
        projectProgressLabel.textAlignment = .center
        projectProgressLabel.textColor = .label
        return projectProgressLabel
    }()
    
    private let projectCreationDate: UILabel = {
        let projectCreationDate = UILabel()
        projectCreationDate.translatesAutoresizingMaskIntoConstraints = false
        projectCreationDate.font = .preferredFont(forTextStyle: .body)
        projectCreationDate.textAlignment = .center
        projectCreationDate.textColor = .label
        return projectCreationDate
    }()
    
    init() {
        super.init(frame: .zero)
        addSubview(projectTitleLabel)
        addSubview(projectDescriptionLabel)
        addSubview(projectIconImageView)
        addSubview(projectPriorityLabel)
        addSubview(projectProgressLabel)
        addSubview(projectCreationDate)
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

            projectDescriptionLabel.topAnchor.constraint(equalTo: projectTitleLabel.bottomAnchor, constant: 10),
            projectDescriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectDescriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),

            projectIconImageView.topAnchor.constraint(equalTo: projectDescriptionLabel.bottomAnchor, constant: 10),
            projectIconImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            projectIconImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            projectIconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            projectPriorityLabel.topAnchor.constraint(equalTo: projectIconImageView.bottomAnchor, constant: 10),
            projectPriorityLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectPriorityLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            projectProgressLabel.topAnchor.constraint(equalTo: projectPriorityLabel.bottomAnchor, constant: 10),
            projectProgressLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectProgressLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            
            projectCreationDate.topAnchor.constraint(equalTo: projectProgressLabel.bottomAnchor, constant: 10),
            projectCreationDate.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            projectCreationDate.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    public func configure(with project: Project) {
        projectTitleLabel.text = project.projectTitle ?? "-"
        projectDescriptionLabel.text = "Description: \(project.projectDescription ?? "-")"
        projectIconImageView.image = UIImage(data: project.icon!)
        projectPriorityLabel.text = "Priority: \(project.projectPriority ?? "-")"
        projectProgressLabel.text = "Progress: \(project.projectProgress ?? "-")"
        projectCreationDate.text = "Creation date: \(project.creationDate?.formatted(date: .complete, time: .omitted) ?? "-")"
    }
}
