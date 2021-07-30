//
//  QuestionsRepository.swift
//  somequizz
//
//  Created by Gabriel Puppi on 29/07/21.
//

import Foundation


class QuestionsRepository {
   
    static let shared = QuestionsRepository()
    
    let questions = [Question(question: "Why is there something instead of nothing?", questionNum: "First question", answer1: "They both co-exist",                       answer2: "because of god", answer3: "I don't know", questionImage: "infinitecircle", rightAnswer: "I don't know"),
                     Question(question: "When did time begin?", questionNum: "Second question", answer1: "before it's existence", answer2: "when clocks were invented", answer3: "I don't know", questionImage: "infinitecircle", rightAnswer: "before it's existence"),
                     Question(question: "How the universe came to exist??", questionNum: "Third question", answer1: "before it's existence", answer2: "when clocks were invented", answer3: "I don't know", questionImage: "infinitecircle", rightAnswer: "before it's existence"),
                     Question(question: "Who are you?", questionNum: "Fourth question", answer1: "before it's existence", answer2: "when clocks were invented", answer3: "I don't know", questionImage: "infinitecircle", rightAnswer: "before it's existence"),
                     Question(question: "Where does black mustard comes from?", questionNum: "Fifth question", answer1: "The mustard crop", answer2: "sea of hapiness", answer3: "sausage waste", questionImage: "infinite circle", rightAnswer: "The mustard crop")]

   
    fileprivate init() {}
}
