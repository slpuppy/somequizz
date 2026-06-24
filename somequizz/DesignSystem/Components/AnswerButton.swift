//
//  AnswerButton.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//
import SwiftUI

// MARK: - Shared Button Style (press animation)

struct PressableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

// MARK: - Answer Button Component

struct AnswerButton: View {

    let title: String
    let state: AnswerState
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 0) {
                Text(title)
                    .font(state == .correct
                          ? .system(size: 16, weight: .bold)
                          : .system(size: 16))
                    .foregroundColor(.mainColor)
                    .padding(.leading, 20)
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.mainColor, lineWidth: state == .normal ? 1 : 0)
            )
            .cornerRadius(30)
            .opacity(state == .revealed ? 0.7 : 1.0)
            .contentShape(RoundedRectangle(cornerRadius: 30))
        }
        .disabled(state != .normal)
        .buttonStyle(PressableButtonStyle())
    }

    private var backgroundColor: Color {
        switch state {
        case .normal:    return .clear
        case .correct:   return .mainGreen
        case .incorrect: return .mainRed
        case .revealed:  return .white.opacity(0.5)
        }
    }
}
