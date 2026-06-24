//
//  String+Localized.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

// MARK: String Localization

public func localizeString(_ stringToLocalize: String) -> String {
    return NSLocalizedString(stringToLocalize, comment: "").precomposedStringWithCanonicalMapping
}

public func localizeStringFromTable(_ stringToLocalize: String, tableName: String) -> String {
    return NSLocalizedString(stringToLocalize, tableName: tableName, comment: "").precomposedStringWithCanonicalMapping
}
