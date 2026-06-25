//
//  EndViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

class EndViewModel: ObservableObject {

    @Published var screenData: EndScreenData?
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
        let score = await scoreContent
        let state = await gameOverContent
        screenData = mapToScreenData(score: score, state: state)
        isLoading = false
    }

    // MARK: - Private

    private func mapToScreenData(score: ScreenContent?, state: ScreenContent?) -> EndScreenData {
        let key = resultKey
        return EndScreenData(
            firstLine: score?.label1 ?? localizeString("end.first_line"),
            secondLine: state?.label2 ?? score?.label2 ?? localizeString("end.\(key).second_line"),
            scoreSub: score?.label3 ?? localizeString("end.\(key).score_sub"),
            resultText: state?.title ?? score?.title ?? localizeString("end.\(key).result"),
            lastText: state?.subtitle ?? score?.subtitle ?? localizeString("end.\(key).last_text"),
            buttonTitle: state?.buttons?.first?.title ?? localizeString("end.\(key).button"),
            scoreText: String(format: localizeString("end.score_format"), rightCount, totalQuestions),
            isButtonEnabled: !isGameOver
        )
    }

    private var resultKey: String {
        switch rightCount {
        case 9:  return "secret"
        case 10: return "won"
        case 11: return "flawless"
        default: return "lost"
        }
    }
}
