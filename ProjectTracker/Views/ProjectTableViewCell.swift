//
//  ProjectTableViewCell.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 26.04.2024.
//

import UIKit

final class ProjectTableViewCell: UITableViewCell {
    static let identifier = "ProjectTableViewCell"
    
    private let projectImageView: UIImageView = {
        let projectImageView = UIImageView()
        projectImageView.translatesAutoresizingMaskIntoConstraints = false
        projectImageView.contentMode = .scaleAspectFill
        projectImageView.clipsToBounds = true
        return projectImageView
    }()
    
    private let projectTitleLabel: UILabel = {
        let projectTitleLabel = UILabel()
        projectTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        projectTitleLabel.numberOfLines = 0
        projectTitleLabel.textColor = .label
        projectTitleLabel.textAlignment = .center
        projectTitleLabel.font = .preferredFont(forTextStyle: .title3)
        return projectTitleLabel
    }()
    
    private let projectDetailsLabel: UILabel = {
        let projectDetailsLabel = UILabel()
        projectDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        projectDetailsLabel.numberOfLines = 0
        projectDetailsLabel.textColor = .label
        projectDetailsLabel.textAlignment = .left
        projectDetailsLabel.font = .preferredFont(forTextStyle: .subheadline)
        return projectDetailsLabel
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(projectImageView)
        contentView.addSubview(projectTitleLabel)
        contentView.addSubview(projectDetailsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        projectImageView.image = nil
        projectTitleLabel.text = nil
        projectDetailsLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        NSLayoutConstraint.activate([
            projectImageView.heightAnchor.constraint(equalToConstant: (contentView.frame.size.width * 0.3)),
            projectImageView.widthAnchor.constraint(equalToConstant: (contentView.frame.size.width * 0.3) - 10),
            projectImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            projectImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            projectImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            projectTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            projectTitleLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 5),
            projectTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            projectDetailsLabel.topAnchor.constraint(equalTo: projectTitleLabel.bottomAnchor, constant: 5),
            projectDetailsLabel.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 5),
            projectDetailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            projectDetailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
        
        print(projectImageView.frame.size.height)
        print(projectImageView.frame.size.width)

    }
    
    func setup(with project: Project) {
        if let icon = project.icon {
            projectImageView.image = UIImage(data: icon)
        }
        else {
            projectImageView.image = UIImage(named: "icon")
        }
        projectTitleLabel.text = project.projectTitle
        projectDetailsLabel.text = "Priority: \(project.projectPriority)\nProgress: \(project.projectProgress)\nCreation date: \(project.creationDate.formatted())"
    }
}
