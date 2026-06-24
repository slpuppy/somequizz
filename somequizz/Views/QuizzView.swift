//
//  QuizzView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI

// MARK: - Quiz Screen

struct QuizzView: View {

    @ObservedObject var viewModel: QuizViewModel
    let onEnd: () -> Void

    @State private var tappedIndex: Int? = nil
    @State private var isCorrect: Bool = false

    private var question: Question { viewModel.currentQuestion }

    var body: some View {
        ZStack {
           Color.mainColorInvert.ignoresSafeArea()

            VStack(spacing: 0) {
                // Question header
                VStack(alignment: .leading, spacing: 2) {
                    Text(question.questionNum)
                        .font(.system(size: 16))
                        .foregroundColor(.mainColor)

                    Text(question.question)
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(.mainColor)
                        .fixedSize(horizontal: false, vertical: true)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)
                .padding(.top, 100)

                Color.clear.frame(height: 83)

                // Question image — .id resets animation state on question change
                QuizImageView(
                    imageName: question.questionImage,
                    animationType: question.animationType
                )
                .frame(maxWidth: .infinity)
                .frame(height: 128)
                .padding(.horizontal, 10)
                .id(viewModel.currentQuestionIndex)

                Spacer()

                // Answer buttons
                VStack(spacing: 10) {
                    answerButton(index: 0, title: question.answer1)
                    answerButton(index: 1, title: question.answer2)
                    answerButton(index: 2, title: question.answer3)
                }
                .padding(.horizontal, 20)

                Color.clear.frame(height: 80)
            }
        }
    }

    // MARK: - Private

    @ViewBuilder
    private func answerButton(index: Int, title: String) -> some View {
        AnswerButton(title: title, state: buttonState(for: index)) {
            handleTap(index: index, title: title)
        }
    }

    private func buttonState(for index: Int) -> AnswerState {
        guard let tapped = tappedIndex else { return .normal }
        if index == tapped {
            return isCorrect ? .correct : .incorrect
        }
        return .revealed
    }

    private func handleTap(index: Int, title: String) {
        let correct = viewModel.submitAnswer(title)
        tappedIndex = index
        isCorrect = correct

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if viewModel.hasNextQuestion {
                viewModel.advance()
                tappedIndex = nil
                isCorrect = false
            } else {
                onEnd()
            }
        }
    }
}
