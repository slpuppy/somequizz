//
//  LocalStorageManager.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

enum LocalStorageKey: String {
    case useDynamicQuestions
    case dailyAttempts
    case attemptsUsed
    case bestScore
    case lastPlayedDate
}

struct LocalStorageManager {

    static func set(_ value: Bool, for key: LocalStorageKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func bool(for key: LocalStorageKey) -> Bool {
        UserDefaults.standard.bool(forKey: key.rawValue)
    }

    static func set(_ value: Int, for key: LocalStorageKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func int(for key: LocalStorageKey) -> Int {
        UserDefaults.standard.integer(forKey: key.rawValue)
    }

    static func set(_ value: String, for key: LocalStorageKey) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }

    static func string(for key: LocalStorageKey) -> String? {
        UserDefaults.standard.string(forKey: key.rawValue)
    }
}
