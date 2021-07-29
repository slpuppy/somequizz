//
//  Question.swift
//  somequizz
//
//  Created by Gabriel Puppi on 28/07/21.
//

import Foundation




class Question {
    
    let question: String
    let questionNum: String
    let answer1: String
    let answer2: String
    let answer3: String
    let questionImage: String
    
    let rightAnswer: String
    
    internal init(question: String, questionNum: String, answer1: String, answer2: String, answer3: String, questionImage: String, rightAnswer: String) {
        self.question = question
        self.questionNum = questionNum
        self.answer1 = answer1
        self.answer2 = answer2
        self.answer3 = answer3
        self.questionImage = questionImage
        self.rightAnswer = rightAnswer
    }
    
    
    
    
}
