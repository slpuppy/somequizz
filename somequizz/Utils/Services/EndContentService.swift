//
//  EndContentService.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import FirebaseFirestore

protocol EndContentServiceProtocol {
    func fetchContent(forScore score: Int) async throws -> ScreenContent
    func fetchGameOverContent() async throws -> ScreenContent
}

class FirestoreEndContentService: EndContentServiceProtocol {

    func fetchContent(forScore score: Int) async throws -> ScreenContent {
        let snapshot = try await Firestore.firestore()
            .collection("content")
            .document(scoreDocumentKey(for: score))
            .getDocument()
        return try snapshot.data(as: ScreenContent.self)
    }

    func fetchGameOverContent() async throws -> ScreenContent {
        let snapshot = try await Firestore.firestore()
            .collection("content")
            .document("end_gameOver")
            .getDocument()
        return try snapshot.data(as: ScreenContent.self)
    }

    // MARK: - Private

    private func scoreDocumentKey(for score: Int) -> String {
        switch score {
        case 9:  return "end_secret"
        case 10: return "end_won"
        case 11: return "end_flawless"
        default: return "end_default"
        }
    }
}
