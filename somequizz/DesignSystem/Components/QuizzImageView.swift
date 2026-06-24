//
//  QuizzImageView.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//
import SwiftUI

// MARK: - Quiz Image Component

struct QuizImageView: View {

    let imageName: String
    let animationType: AnimationType

    @State private var rotationAngle: Double = 0
    @State private var pendulumAngle: Double = -17.2

    var body: some View {
        Group {
            if animationType == .rotate {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(rotationAngle))
                    .onAppear {
                        withAnimation(
                            .linear(duration: 4.0)
                            .repeatForever(autoreverses: false)
                        ) {
                            rotationAngle = 360
                        }
                    }
            } else {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(
                        .degrees(pendulumAngle),
                        anchor: UnitPoint(x: 0.5, y: 0.2)
                    )
                    .onAppear {
                        withAnimation(
                            .easeInOut(duration: 2.0)
                            .repeatForever(autoreverses: true)
                        ) {
                            pendulumAngle = 18.0
                        }
                    }
            }
        }
    }
}
