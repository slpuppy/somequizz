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
                Text(String(format: localizeString("end.score_format"), viewModel.rightCount, viewModel.totalQuestions))
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
                firstLine:   localizeString("end.first_line"),
                secondLine:  localizeString("end.secret.second_line"),
                scoreSub:    localizeString("end.secret.score_sub"),
                resultText:  localizeString("end.secret.result"),
                lastText:    localizeString("end.secret.last_text"),
                buttonTitle: localizeString("end.secret.button")
            )
        case 10:
            return ResultInfo(
                firstLine:   localizeString("end.first_line"),
                secondLine:  localizeString("end.won.second_line"),
                scoreSub:    localizeString("end.won.score_sub"),
                resultText:  localizeString("end.won.result"),
                lastText:    localizeString("end.won.last_text"),
                buttonTitle: localizeString("end.won.button")
            )
        case 11:
            return ResultInfo(
                firstLine:   localizeString("end.first_line"),
                secondLine:  localizeString("end.flawless.second_line"),
                scoreSub:    localizeString("end.flawless.score_sub"),
                resultText:  localizeString("end.flawless.result"),
                lastText:    localizeString("end.flawless.last_text"),
                buttonTitle: localizeString("end.flawless.button")
            )
        default: // 0–8
            return ResultInfo(
                firstLine:   localizeString("end.first_line"),
                secondLine:  localizeString("end.lost.second_line"),
                scoreSub:    localizeString("end.lost.score_sub"),
                resultText:  localizeString("end.lost.result"),
                lastText:    localizeString("end.lost.last_text"),
                buttonTitle: localizeString("end.lost.button")
            )
        }
    }
}
