//
//  EndViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

class EndViewModel: ObservableObject {

    @Published var content: ScreenContent?
    @Published var stateContent: ScreenContent?
    @Published var isLoading: Bool = true

    let rightCount: Int
    let totalQuestions: Int
    let isGameOver: Bool

    private let service: EndContentServiceProtocol

    init(
        rightCount: Int,
        totalQuestions: Int,
        isGameOver: Bool,
        service: EndContentServiceProtocol = FirestoreEndContentService()
    ) {
        self.rightCount = rightCount
        self.totalQuestions = totalQuestions
        self.isGameOver = isGameOver
        self.service = service
        Task { await loadContent() }
    }

    @MainActor
    private func loadContent() async {
        async let scoreContent = try? service.fetchContent(forScore: rightCount)
        async let gameOverContent = isGameOver ? (try? service.fetchGameOverContent()) : nil
        content = await scoreContent
        self.stateContent = await gameOverContent
        isLoading = false
    }

    // MARK: - Display properties

    var firstLine: String   { content?.label1                                           ?? localizeString("end.first_line") }
    var secondLine: String  { stateContent?.label2  ?? content?.label2                  ?? localizeString("end.\(resultKey).second_line") }
    var scoreSub: String    { content?.label3                                           ?? localizeString("end.\(resultKey).score_sub") }
    var resultText: String  { stateContent?.title   ?? content?.title                   ?? localizeString("end.\(resultKey).result") }
    var lastText: String    { stateContent?.subtitle ?? content?.subtitle               ?? localizeString("end.\(resultKey).last_text") }
    var buttonTitle: String { stateContent?.buttons?.first?.title                       ?? localizeString("end.\(resultKey).button") }
    var scoreText: String   { String(format: localizeString("end.score_format"), rightCount, totalQuestions) }
    var isButtonEnabled: Bool { !isGameOver }

    private var resultKey: String {
        switch rightCount {
        case 9:  return "secret"
        case 10: return "won"
        case 11: return "flawless"
        default: return "lost"
        }
    }
}
