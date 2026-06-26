//
//  AppSettingsService.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import FirebaseFirestore

protocol AppSettingsServiceProtocol {
    func fetchSettingsAndCache() async
}

class FirestoreAppSettingsService: AppSettingsServiceProtocol {

    func fetchSettingsAndCache() async {
        resetDailyStateIfNeeded()
        do {
            let snapshot = try await Firestore.firestore()
                .collection("settings")
                .document("app")
                .getDocument()

            guard let data = snapshot.data() else {
                print("[AppSettingsService] No data found, using defaults")
                setDefaults()
                return
            }

            cacheDynamicQuestions(from: data)
            cacheDailyAttempts(from: data)
            cacheResetHour(from: data)

        } catch {
            print("[AppSettingsService] Fetch failed, using defaults: \(error)")
            setDefaults()
        }
    }

    // MARK: - Private

    private func cacheDynamicQuestions(from data: [String: Any]) {
        guard let flag = data["useDynamicQuestions"] as? Bool else {
            print("[AppSettingsService] Missing useDynamicQuestions, defaulting to false")
            LocalStorageManager.set(false, for: .useDynamicQuestions)
            return
        }
        print("[AppSettingsService] useDynamicQuestions=\(flag)")
        LocalStorageManager.set(flag, for: .useDynamicQuestions)
    }

    private func cacheDailyAttempts(from data: [String: Any]) {
        guard let attempts = data["dailyAttempts"] as? Int else {
            print("[AppSettingsService] Missing dailyAttempts, defaulting to 3")
            LocalStorageManager.set(3, for: .dailyAttempts)
            return
        }
        print("[AppSettingsService] dailyAttempts=\(attempts)")
        LocalStorageManager.set(attempts, for: .dailyAttempts)
    }

    private func cacheResetHour(from data: [String: Any]) {
        guard let hour = data["resetHour"] as? Int, (0...23).contains(hour) else {
            print("[AppSettingsService] Missing resetHour, defaulting to 0")
            LocalStorageManager.set(0, for: .resetHour)
            return
        }
        print("[AppSettingsService] resetHour=\(hour)")
        LocalStorageManager.set(hour, for: .resetHour)
    }

    private func resetDailyStateIfNeeded() {
        let sessionKey = currentSessionKey()
        let lastPlayed = LocalStorageManager.string(for: .lastPlayedDate)
        guard lastPlayed != sessionKey else { return }
        print("[AppSettingsService] New session detected, resetting daily state")
        LocalStorageManager.set(0, for: .attemptsUsed)
        LocalStorageManager.set(-1, for: .bestScore)
        LocalStorageManager.set(sessionKey, for: .lastPlayedDate)
    }

    private func currentSessionKey() -> String {
        let resetHour = LocalStorageManager.int(for: .resetHour)
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone(identifier: "UTC")!
        let now = Date()
        let currentHour = calendar.component(.hour, from: now)
        let sessionDate = currentHour >= resetHour ? now : calendar.date(byAdding: .day, value: -1, to: now)!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter.string(from: sessionDate)
    }

    private func setDefaults() {
        LocalStorageManager.set(false, for: .useDynamicQuestions)
        LocalStorageManager.set(3, for: .dailyAttempts)
        LocalStorageManager.set(0, for: .resetHour)
    }
}
