//
//  QuestionsRepository.swift
//  somequizz
//
//  Created by Gabriel Puppi on 29/07/21.
//

import Foundation


class QuestionsRepository {
   
    static let shared = QuestionsRepository()
    
    let questions = [Question(question: "Why is there something instead of nothing?", questionNum: "First question", answer1: "They both co-exist",                                   answer2: "obviously aliens", answer3: "I don't know", questionImage: "circle", rightAnswer: "obviously aliens"),
                     Question(question: "What is always coming but never arrives?", questionNum: "Second question", answer1: "my bus", answer2: "tomorrow", answer3: "the food I ordered", questionImage: "clock", rightAnswer: "tomorrow"),
                     Question(question: "Whats the color of the dress?", questionNum: "Third question", answer1: "black and blue", answer2: "white and gold", answer3: "what dress?", questionImage: "face", rightAnswer: "black and blue"),
                     Question(question: "What happens when you clean a vacuum cleaner ?", questionNum: "Fourth question", answer1: "it becomes clean", answer2: "nothing", answer3: "you become a vacuum cleaner", questionImage: "pendu", rightAnswer: "you become a vacuum cleaner"),
                     Question(question: "When did time begin?", questionNum: "Fifth question", answer1: "before it's existence", answer2: "wait. time is relative", answer3: "at 4:20", questionImage: "eye", rightAnswer: "wait. time is relative"),
                     Question(question: "So, what is time?", questionNum: "Sixth question", answer1: "time is space", answer2: "an illusion", answer3: "a pink floyd song?", questionImage: "pyr", rightAnswer: "a pink floyd song?"),
                     Question(question: "What is the closest thing to real magic?", questionNum: "Seventh question", answer1: "ilusionism", answer2: "chemestry", answer3: "placebo effect", questionImage: "magik", rightAnswer: "placebo effect"),
                     Question(question: "Why do cats purr ?", questionNum: "Eighth question", answer1: "they're relaxed", answer2: "i think it depends", answer3: "they like you", questionImage: "hand", rightAnswer: "i think it depends"),
                     Question(question: "Why do we cook bacon and bake cookies?", questionNum: "Nineth question", answer1: "it's how food works", answer2: "great question", answer3: "terrible question", questionImage: "brain", rightAnswer: "it's how food works"),
                     Question(question: "Fool me once shame on you, fool me twice?", questionNum: "Fake Last question", answer1: "i'm a fool", answer2: "wait, why this question is fake?", answer3: "shame on me?", questionImage: "ohboy", rightAnswer: "i'm a fool"),
                     Question(question: "If the last question was the last then why this question exists?", questionNum: "Real Last question", answer1: "because it was the fake last question", answer2: "because this is the real last question", answer3: "because this quizz is strange", questionImage: "confused", rightAnswer: "because this quizz is strange"),
                     
    ]

   
    fileprivate init() {}
}
