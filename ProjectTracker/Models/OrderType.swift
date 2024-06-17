//
//  OrderType.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 17.06.2024.
//

import Foundation

enum OrderType: Int, CaseIterable {
    case ascending = 0
    case descending = 1
    
    var title: String {
        switch self {
        case .ascending:
            return "Ascending"
        case .descending:
            return "Descending"
        }
    }
    
    var ascendingBoolValue: Bool {
        switch self {
        case .ascending:
            return true
        case .descending:
            return false
        }
    }
}
