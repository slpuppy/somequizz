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
        do {
            let snapshot = try await Firestore.firestore()
                .collection("settings")
                .document("app")
                .getDocument()

            guard let data = snapshot.data(),
                  let flag = data["useDynamicQuestions"] as? Bool else {
                print("[AppSettingsService] Missing or invalid useDynamicQuestions field, data=\(String(describing: snapshot.data()))")
                setDefaults()
                return
            }

            print("[AppSettingsService] useDynamicQuestions=\(flag)")
            LocalStorageManager.set(flag, for: .useDynamicQuestions)
        } catch {
            print("[AppSettingsService] Fetch failed, defaulting to false: \(error)")
            setDefaults()
        }
    }

    private func setDefaults() {
        LocalStorageManager.set(false, for: .useDynamicQuestions)
    }
}
