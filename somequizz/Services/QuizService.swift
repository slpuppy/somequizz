//
//  QuizService.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import FirebaseFirestore

protocol QuizServiceProtocol {
    func fetchQuestions() async throws -> [Question]
}

class FirestoreQuizService: QuizServiceProtocol {

    func fetchQuestions() async throws -> [Question] {
        let db = Firestore.firestore()

        if LocalStorageManager.bool(for: .useDynamicQuestions) {
            if let questions = try? await fetch(document: todayKey(), from: db) {
                return questions
            }
        }

        return try await fetch(document: "default", from: db)
    }

    private func fetch(document id: String, from db: Firestore) async throws -> [Question] {
        let snapshot = try await db.collection("questions").document(id).getDocument()
        let data = try snapshot.data(as: QuestionDocument.self)
        return data.questions
    }

    private func todayKey() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

private struct QuestionDocument: Codable {
    let questions: [Question]
}
