//
//  QuizzViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

class QuizViewModel: ObservableObject {

    @Published var questions: [Question] = []
    @Published var currentQuestionIndex: Int = 0
    @Published var rightCount: Int = 0
    @Published var wrongCount: Int = 0
    @Published var isLoading: Bool = true

    private let service: QuizServiceProtocol

    init(service: QuizServiceProtocol = FirestoreQuizService()) {
        self.service = service
        Task { await loadQuestions() }
    }

    var totalQuestions: Int { questions.count }
    var currentQuestion: Question { questions[currentQuestionIndex] }
    var hasNextQuestion: Bool { currentQuestionIndex + 1 < questions.count }

    @discardableResult
    func submitAnswer(_ option: String) -> Bool {
        let correct = option == currentQuestion.rightAnswer
        if correct { rightCount += 1 } else { wrongCount += 1 }
        return correct
    }

    func advance() {
        guard hasNextQuestion else { return }
        currentQuestionIndex += 1
    }

    func reset() {
        currentQuestionIndex = 0
        rightCount = 0
        wrongCount = 0
    }

    // MARK: - Private

    @MainActor
    private func loadQuestions() async {
        await FirestoreAppSettingsService().fetchSettingsAndCache()
        do {
            questions = try await service.fetchQuestions()
        } catch {
            print("[QuizViewModel] Firestore fetch failed: \(error)")
            questions = LocalQuestionsRepository.shared.loadQuestions()
        }
        isLoading = false
    }
}
