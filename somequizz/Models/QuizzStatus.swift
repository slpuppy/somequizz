//
//  QuizzStatus.swift
//  somequizz
//
//  Created by Gabriel Puppi on 29/07/21.
//

import Foundation


class QuizzStatus {
   
    var questions: [Question]
    var totalQuestion: Int
    var rightCount:Int
    var wrongCount:Int
  
    
    internal init(questions: [Question]) {
        self.questions = questions
        self.totalQuestion = questions.count
        self.rightCount = 0
        self.wrongCount = 0
    }

    



}
