//
//  UserDefaultsManager.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 07.06.2024.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let standart = UserDefaults.standard
    
    private init() {}
    
    enum storedVariables {
        case sortType
        case orderType
        
        var forKey: String {
            switch self {
            case .sortType:
                return "sortType"
            case .orderType:
                return "orderType"
            }
        }
    }
    
    public func loadValue(for storedVariable: storedVariables) -> Int {
        return standart.integer(forKey: storedVariable.forKey)
    }
    
    public func setValue(for storedVariable: storedVariables, value: Int) {
        standart.setValue(value, forKey: storedVariable.forKey)
    }
}
