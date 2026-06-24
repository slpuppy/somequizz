//
//  MainContentService.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import FirebaseFirestore

protocol MainContentServiceProtocol {
    func fetchContent() async throws -> ScreenContent
}

class FirestoreMainContentService: MainContentServiceProtocol {

    func fetchContent() async throws -> ScreenContent {
        let snapshot = try await Firestore.firestore()
            .collection("content")
            .document("main")
            .getDocument()
        return try snapshot.data(as: ScreenContent.self)
    }
}
