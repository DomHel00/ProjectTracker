//
//  NoProjectsTableViewDataVIew.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 21.04.2024.
//

import UIKit

final class NoProjectsTableViewDataVIew: UIView {
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
        titleLabel.text = "No data yet!"
        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(iconImageView)
        addSubview(titleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
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
