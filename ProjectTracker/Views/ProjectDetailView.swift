//
//  ProjectDetailView.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 27.04.2024.
//

import UIKit

final class ProjectDetailView: UIView {
    let project: Project
    
    init(project: Project) {
        self.project = project
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
