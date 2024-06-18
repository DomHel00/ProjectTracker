//
//  Extensions.swift
//  ProjectTracker
//
//  Created by Dominik Hel on 01.06.2024.
//

import Foundation

extension String {
    var isValidURL: Bool {
        let regex = "^(http|https)://([\\w_-]+(?:(?:\\.[\\w_-]+)+))([\\w.,@?^=%&:/+;\\*]*)?$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
}

extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
