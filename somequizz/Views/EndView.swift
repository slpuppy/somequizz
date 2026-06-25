//
//  EndView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI

struct EndView: View {

    @ObservedObject var viewModel: EndViewModel
    let onReset: () -> Void

    @State private var rotationAngle: Double = 0

    var body: some View {
        ZStack {
            Color.mainColorInvert.ignoresSafeArea()

            VStack(spacing: 0) {
                Spacer()

                // Header lines
                VStack(alignment: .leading, spacing: 1) {
                    Text(viewModel.screenData?.firstLine ?? "")
                        .font(.system(size: 21, weight: .bold))
                        .foregroundColor(.mainColor)
                    Text(viewModel.screenData?.secondLine ?? "")
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
                Text(viewModel.screenData?.scoreText ?? "")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.mainColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)

                Color.clear.frame(height: 10)

                Text(viewModel.screenData?.scoreSub ?? "")
                    .font(.system(size: 13, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)

                Color.clear.frame(height: 10)

                Text(viewModel.screenData?.resultText ?? "")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.mainColor)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 30)

                Color.clear.frame(height: 8)

                Text(viewModel.screenData?.lastText ?? "")
                    .font(.system(size: 14, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 32)

                Color.clear.frame(height: 50)

                Button {
                    onReset()
                } label: {
                    Text(viewModel.screenData?.buttonTitle ?? "")
                        .font(.system(size: 18))
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .foregroundColor(.mainColorInvert)
                        .background(Color.mainColor)
                        .cornerRadius(30)
                        .opacity((viewModel.screenData?.isButtonEnabled ?? true) ? 1 : 0.4)
                }
                .buttonStyle(PressableButtonStyle())
                .disabled(!(viewModel.screenData?.isButtonEnabled ?? true))
                .padding(.horizontal, 30)

                Color.clear.frame(height: 80)
            }
        }
    }
}
