//
//  LocalStorageManager.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

enum LocalStorageKey: String {
    case useDynamicQuestions
}

struct LocalStorageManager {

    static func set(_ value: Bool, for key: LocalStorageKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func bool(for key: LocalStorageKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }
}
