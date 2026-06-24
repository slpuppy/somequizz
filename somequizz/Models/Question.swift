//
//  Question.swift
//  Strangequizz
//
//  Created by Gabriel Puppi on 24/06/26.
//

import Foundation

enum AnimationType: String, Codable {
    case rotate
    case pendulum
}

struct Question: Codable {
    let question: String
    let questionNum: String
    let answer1: String
    let answer2: String
    let answer3: String
    let questionImage: String
    let rightAnswer: String
    let animationType: AnimationType
}
