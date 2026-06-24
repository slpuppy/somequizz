//
//  ContentView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI

struct ContentView: View {

    @State private var screen: AppScreen = .main
    @StateObject private var viewModel = QuizViewModel()

    var body: some View {
        switch screen {
        case .main:
            MainView {
                screen = .quiz
            }
        case .quiz:
            QuizzView(viewModel: viewModel) {
                screen = .end
            }
        case .end:
            EndView(viewModel: viewModel) {
                viewModel.reset()
                screen = .main
            }
        }
    }
}
