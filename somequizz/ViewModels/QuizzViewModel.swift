//
//  QuizzViewModel.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation
import Combine

class QuizViewModel: ObservableObject {

    @Published var currentQuestionIndex: Int = 0
    @Published var rightCount: Int = 0
    @Published var wrongCount: Int = 0

    private(set) var questions: [Question]
    private let repository: QuestionsRepositoryProtocol

    init(repository: QuestionsRepositoryProtocol = LocalQuestionsRepository.shared) {
        self.repository = repository
        self.questions = repository.loadQuestions()
    }

    var totalQuestions: Int { questions.count }
    var currentQuestion: Question { questions[currentQuestionIndex] }
    var hasNextQuestion: Bool { currentQuestionIndex + 1 < questions.count }

    @discardableResult
    func submitAnswer(_ option: String) -> Bool {
        let correct = option == currentQuestion.rightAnswer
        if correct {
            rightCount += 1
        } else {
            wrongCount += 1
        }
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
        questions = repository.loadQuestions()
    }
}
