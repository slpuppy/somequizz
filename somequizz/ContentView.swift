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

    var body: some View {
        switch screen {
        case .main:
            MainView(viewModel: mainViewModel, isQuizReady: !quizViewModel.isLoading) {
                screen = .quiz
            }
        case .quiz:
            QuizzView(viewModel: quizViewModel) {
                endViewModel = EndViewModel(
                    rightCount: quizViewModel.rightCount,
                    totalQuestions: quizViewModel.totalQuestions
                )
                screen = .end
            }
        case .end:
            if let endVM = endViewModel {
                EndView(viewModel: endVM) {
                    quizViewModel.reset()
                    endViewModel = nil
                    screen = .main
                }
            }
        }
    }
}
