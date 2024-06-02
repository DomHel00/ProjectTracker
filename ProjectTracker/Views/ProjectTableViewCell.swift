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
        projectImageView.layer.cornerRadius = 8
        return projectImageView
    }()
    
    private let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fillProportionally
        return verticalStackView
    }()
    
    private let projectTitleLabel: UILabel = {
        let projectTitleLabel = UILabel()
        projectTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        projectTitleLabel.numberOfLines = 0
        projectTitleLabel.textColor = .label
        projectTitleLabel.textAlignment = .left
        projectTitleLabel.font = .preferredFont(forTextStyle: .title3)
        projectTitleLabel.clipsToBounds = true
        return projectTitleLabel
    }()
    
    private let projectDetailsLabel: UILabel = {
        let projectDetailsLabel = UILabel()
        projectDetailsLabel.translatesAutoresizingMaskIntoConstraints = false
        projectDetailsLabel.numberOfLines = 0
        projectDetailsLabel.textColor = .label
        projectDetailsLabel.textAlignment = .left
        projectDetailsLabel.font = .preferredFont(forTextStyle: .body)
        projectDetailsLabel.clipsToBounds = true
        return projectDetailsLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.backgroundColor = .systemFill
        contentView.addSubview(projectImageView)
        contentView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(projectTitleLabel)
        verticalStackView.addArrangedSubview(projectDetailsLabel)
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
            projectImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            projectImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            projectImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

            projectImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            projectImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),

            verticalStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            verticalStackView.leadingAnchor.constraint(equalTo: projectImageView.trailingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            verticalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
    
    public func configureUI(with project: Project) {
        if let icon = project.icon {
            projectImageView.image = UIImage(data: icon)
        }
        else {
            projectImageView.image = UIImage(named: "icon")
        }
        projectTitleLabel.text = project.projectTitle
        projectDetailsLabel.text = "Priority: \(project.projectPriority)\nProgress: \(project.projectProgress)\nCreation date: \(project.creationDate.formatted(date: .numeric, time: .omitted))"
    }
}
