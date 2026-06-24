//
//  EndView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI

struct EndView: View {

    @ObservedObject var viewModel: QuizViewModel
    let onReset: () -> Void

    @State private var rotationAngle: Double = 0

    var body: some View {
        ZStack {
            Color.mainColorInvert.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Header lines
                VStack(alignment: .leading, spacing: 1) {
                    Text(result.firstLine)
                        .font(.system(size: 21, weight: .bold))
                        .foregroundColor(.mainColor)
                    Text(result.secondLine)
                        .font(.system(size: 15))
                        .foregroundColor(.mainColor)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 30)

                Color.clear.frame(height: 100)

                // Rotating infinity image
                Image("infinitecircle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 240, height: 128)
                    .rotationEffect(.degrees(rotationAngle))
                    .onAppear {
                        withAnimation(
                            .linear(duration: 4.0)
                            .repeatForever(autoreverses: false)
                        ) {
                            rotationAngle = 360
                        }
                    }

                Color.clear.frame(height: 100)

                // Score
                Text("Scored \(viewModel.rightCount)/\(viewModel.totalQuestions) stranger...")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.mainColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)

                Color.clear.frame(height: 10)

                Text(result.scoreSub)
                    .font(.system(size: 13, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)

                Color.clear.frame(height: 10)

                Text(result.resultText)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.mainColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)

                Color.clear.frame(height: 8)

                Text(result.lastText)
                    .font(.system(size: 14, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)

                Color.clear.frame(height: 50)

                Button {
                    onReset()
                } label: {
                    Text(result.buttonTitle)
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .foregroundColor(.mainColorInvert)
                        .background(Color.mainColor)
                        .cornerRadius(30)
                }
                .buttonStyle(PressableButtonStyle())
                .padding(.horizontal, 30)

                Color.clear.frame(height: 80)
            }
        }
    }

    // MARK: - Result Info

    private struct ResultInfo {
        let firstLine: String
        let secondLine: String
        let scoreSub: String
        let resultText: String
        let lastText: String
        let buttonTitle: String
    }

    private var result: ResultInfo {
        switch viewModel.rightCount {
        case 9:
            return ResultInfo(
                firstLine: "You tried so hard and got so far",
                secondLine: "and in the end...",
                scoreSub: "and YOU LOST!, but fortunatelly...",
                resultText: "you found a secret:",
                lastText: "It was an inside job and this quizz is strange so...",
                buttonTitle: "Try again and win, you're close"
            )
        case 10:
            return ResultInfo(
                firstLine: "You tried so hard and got so far",
                secondLine: "and in the end...",
                scoreSub: "and because this quizz is strange, fortunatelly...",
                resultText: "You won!",
                lastText: "but you made one mistake...",
                buttonTitle: "Try to make none"
            )
        case 11:
            return ResultInfo(
                firstLine: "You tried so hard and got so far",
                secondLine: "and in the end you completely nailed it!",
                scoreSub: "and despite being a strange quizz you were",
                resultText: "Flawless",
                lastText: "this quizz isn't strange for you anymore",
                buttonTitle: "Replay"
            )
        default: // 0–8
            return ResultInfo(
                firstLine: "You tried so hard and got so far",
                secondLine: "but in the end...",
                scoreSub: "and because this quizz is strange, unfortunatelly...",
                resultText: "You lost...",
                lastText: "but you can still...",
                buttonTitle: "Try again"
            )
        }
    }
}
