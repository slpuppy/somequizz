//
//  ContentView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI

struct ContentView: View {

    @State private var screen: AppScreen = .main
    @StateObject private var mainViewModel = MainViewModel()
    @StateObject private var quizViewModel = QuizViewModel()
    @State private var endViewModel: EndViewModel?

    private var isQuizAvailable: Bool {
        let used = LocalStorageManager.int(for: .attemptsUsed)
        let daily = LocalStorageManager.int(for: .dailyAttempts)
        return daily == 0 || used < daily
    }

    var body: some View {
        switch screen {
        case .main:
            MainView(
                viewModel: mainViewModel,
                isQuizReady: !quizViewModel.isLoading,
                isQuizAvailable: isQuizAvailable
            ) {
                screen = .quiz
            }
        case .quiz:
            QuizzView(viewModel: quizViewModel) {
                let isGameOver = recordAttempt(score: quizViewModel.rightCount)
                endViewModel = EndViewModel(
                    rightCount: quizViewModel.rightCount,
                    totalQuestions: quizViewModel.totalQuestions,
                    isGameOver: isGameOver
                )
                screen = .end
            }
        case .end:
            if let endVM = endViewModel {
                EndView(viewModel: endVM) {
                    if endVM.isGameOver {
                        endViewModel = nil
                        screen = .main
                    } else {
                        quizViewModel.reset()
                        endViewModel = nil
                        screen = .quiz
                    }
                }
            }
        }
    }

    // MARK: - Private

    @discardableResult
    private func recordAttempt(score: Int) -> Bool {
        let currentBest = LocalStorageManager.int(for: .bestScore)
        if score > currentBest {
            LocalStorageManager.set(score, for: .bestScore)
        }
        let used = LocalStorageManager.int(for: .attemptsUsed) + 1
        LocalStorageManager.set(used, for: .attemptsUsed)
        let daily = LocalStorageManager.int(for: .dailyAttempts)
        let isGameOver = daily > 0 && used >= daily
        print("[ContentView] attempt \(used)/\(daily), isGameOver=\(isGameOver)")
        return isGameOver
    }
}
