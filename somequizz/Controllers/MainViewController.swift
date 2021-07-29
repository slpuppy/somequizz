//
//  ViewController.swift
//  somequizz
//
//  Created by Gabriel Puppi on 28/07/21.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: AppCoordinatorDelegate?
    
    let nextQuestion = Question(question: "Why is there something instead of nothing?", questionNum: "First question", answer1: "They both co-exist", answer2: "because of god", answer3: "I don't know", questionImage: "infinitecircle", rightAnswer: "I don't know")
    
    @IBOutlet var bg: UIView!
    let mainColor = UIColor(named: "mainColor")
    let mainColorInvert = UIColor(named: "mainColorInvert")
    @IBOutlet var background: UIView!
    
    @IBOutlet weak var launchImage: UIImageView!
    
    
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bg.backgroundColor = mainColorInvert
       
        startButton.layer.cornerRadius = 30
        
   
        
        // Do any additional setup after loading the view.
    }

    @IBAction func didPress(_ sender: Any) {
    
        self.coordinator?.presentQuizz(item: nextQuestion )
    
    }
    
}

