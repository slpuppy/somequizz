//
//  EndViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

class EndViewModel: ObservableObject {

    @Published var content: ScreenContent?
    @Published var isLoading: Bool = true

    let rightCount: Int
    let totalQuestions: Int

    private let service: EndContentServiceProtocol

    init(rightCount: Int, totalQuestions: Int, service: EndContentServiceProtocol = FirestoreEndContentService()) {
        self.rightCount = rightCount
        self.totalQuestions = totalQuestions
        self.service = service
        Task { await loadContent() }
    }

    @MainActor
    private func loadContent() async {
        do {
            content = try await service.fetchContent(forScore: rightCount)
        } catch {
            print("[EndViewModel] Firestore fetch failed: \(error)")
        }
        isLoading = false
    }

    // MARK: - Display properties (Firestore value ?? localizeString fallback)

    var firstLine: String   { content?.label1              ?? localizeString("end.first_line") }
    var secondLine: String  { content?.label2              ?? localizeString("end.\(resultKey).second_line") }
    var scoreSub: String    { content?.label3              ?? localizeString("end.\(resultKey).score_sub") }
    var resultText: String  { content?.title               ?? localizeString("end.\(resultKey).result") }
    var lastText: String    { content?.subtitle            ?? localizeString("end.\(resultKey).last_text") }
    var buttonTitle: String { content?.buttons?.first?.title ?? localizeString("end.\(resultKey).button") }
    var scoreText: String   { String(format: localizeString("end.score_format"), rightCount, totalQuestions) }

    private var resultKey: String {
        switch rightCount {
        case 9:  return "secret"
        case 10: return "won"
        case 11: return "flawless"
        default: return "lost"
        }
    }
}
