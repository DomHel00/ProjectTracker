//
//  NoProjectsTableViewDataVIew.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

// MARK: Imports
import UIKit

// MARK: NoProjectsTableViewDataVIew class
final class NoProjectsTableViewDataVIew: UIView {
    // MARK: UI components
    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.image = UIImage(systemName: "note.text.badge.plus")
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .label
        return iconImageView
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "No projects yet!".localized()
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        return titleLabel
    }()
    
    // MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(titleLabel)
        self.isAccessibilityElement = true
        self.accessibilityLabel = "No projects yet!".localized()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Life cycle functions
    override func layoutSubviews() {
        super.layoutSubviews()
        // Sets constraints.
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            iconImageView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -5)
        ])
    }
}
