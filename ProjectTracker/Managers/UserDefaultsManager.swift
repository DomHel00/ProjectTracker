//
//  UserDefaultsManager.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 07.06.2024.
//

// MARK: Imports
import Foundation

// MARK: UserDefaultsManager class
final class UserDefaultsManager {
    // MARK: Constants and variables
    static let shared = UserDefaultsManager()
    
    private let standart = UserDefaults.standard
    
    // MARK: Inits
    private init() {}
    
    // MARK: StoredVariables enum
    enum StoredVariables {
        // MARK: Cases
        case sortType
        case orderType
        
        // MARK: Computed properties
        /// Returns forKey string for  case.
        var forKey: String {
            switch self {
            case .sortType:
                return "sortType"
            case .orderType:
                return "orderType"
            }
        }
    }
    
    // MARK: Functions
    /// Returns saved int value for selected stored variable  or default value.
    ///
    /// - Parameters:
    ///     - storedVariable: The variable for which we want to retrieve the stored value.
    public func loadValue(for storedVariable: StoredVariables) -> Int {
        return standart.integer(forKey: storedVariable.forKey)
    }
    
    /// Sets value  for selected stored variable.
    ///
    /// - Parameters:
    ///     - storedVariable: The variable for which we want to save the new value.
    ///     - value: The value  which will be saved into the stored variable.
    public func setValue(for storedVariable: StoredVariables, value: Int) {
        standart.setValue(value, forKey: storedVariable.forKey)
    }
}
