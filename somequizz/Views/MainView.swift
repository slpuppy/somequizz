//
//  MainView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import SwiftUI

struct MainView: View {

    @ObservedObject var viewModel: MainViewModel
    let isQuizReady: Bool
    let onStart: () -> Void

    @State private var pendulumAngle: Double = -17.2

    var body: some View {
        ZStack {
            Color.mainColorInvert.ignoresSafeArea()

            VStack(spacing: 0) {
                Image("launch")
                    .resizable()
                    .scaledToFit()
                    .padding(.horizontal, 30)
                    .padding(.vertical, 40)
                    .rotationEffect(.degrees(pendulumAngle), anchor: .top)
                    .frame(maxHeight: 350)
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 2.0)
                            .repeatForever(autoreverses: true)
                        ) {
                            pendulumAngle = 18.0
                        }
                    }

                Text(viewModel.title)
                    .font(.system(size: 28, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)

                Text(viewModel.subtitle)
                    .font(.system(size: 20, weight: .light))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 20)
                    .padding(.top, 10)

                Color.clear.frame(height: 50)

                Button {
                    onStart()
                } label: {
                    Group {
                        if isQuizReady {
                            Text(viewModel.startButton)
                        } else {
                            ProgressView()
                                .tint(.mainColorInvert)
                        }
                    }
                    .font(.system(size: 18))
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .foregroundColor(.mainColorInvert)
                    .background(Color.mainColor)
                    .cornerRadius(30)
                }
                .disabled(!isQuizReady)
                .buttonStyle(PressableButtonStyle())
                .padding(.horizontal, 30)

                Color.clear.frame(height: 150)
            }
        }
    }
}
