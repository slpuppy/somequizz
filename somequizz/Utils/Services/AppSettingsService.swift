//
//  AppSettingsService.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import FirebaseFirestore

private enum UserDefaultsKey {
    static let useDynamicQuestions = "useDynamicQuestions"
}

protocol AppSettingsServiceProtocol {
    func fetchSettingsAndCache() async
}

class FirestoreAppSettingsService: AppSettingsServiceProtocol {

    func fetchSettingsAndCache() async {
        do {
            let snapshot = try await Firestore.firestore()
                .collection("settings")
                .document("app")
                .getDocument()

            guard let data = snapshot.data(),
                  let flag = data["useDynamicQuestions"] as? Bool else {
                setDefault()
                return
            }

            UserDefaults.standard.set(flag, forKey: UserDefaultsKey.useDynamicQuestions)
        } catch {
            print("[AppSettingsService] Fetch failed, defaulting to false: \(error)")
            setDefault()
        }
    }

    private func setDefault() {
        UserDefaults.standard.set(false, forKey: UserDefaultsKey.useDynamicQuestions)
    }
}

extension UserDefaults {
    var useDynamicQuestions: Bool {
        bool(forKey: UserDefaultsKey.useDynamicQuestions)
    }
}
