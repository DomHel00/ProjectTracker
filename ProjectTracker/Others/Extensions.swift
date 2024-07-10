//
//  Extensions.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 01.06.2024.
//

// MARK: Imports
import Foundation

// MARK: String extension
extension String {
    /// Returns bool value for isValid property.
    var isValidURL: Bool {
        let regex = "^(http|https)://([\\w_-]+(?:(?:\\.[\\w_-]+)+))([\\w.,@?^=%&:/+;\\*]*)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    /// Returns localized string if it is possible.
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
