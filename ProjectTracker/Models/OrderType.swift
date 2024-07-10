//
//  OrderType.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 17.06.2024.
//

// MARK: Imports
import Foundation

// MARK: OrderType enum
enum OrderType: Int, CaseIterable {
    // MARK: Cases
    case ascending = 0
    case descending = 1
    
    // MARK: Computed properties
    /// Returns the title for case.
    var title: String {
        switch self {
        case .ascending:
            return "Ascending".localized()
        case .descending:
            return "Descending".localized()
        }
    }
    
    /// Returns the ascending bool value for case.
    var ascendingBoolValue: Bool {
        switch self {
        case .ascending:
            return true
        case .descending:
            return false
        }
    }
}
