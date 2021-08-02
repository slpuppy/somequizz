//
//  ViewController.swift
//  somequizz
//
//  Created by Gabriel Puppi on 28/07/21.
//

import UIKit

class MainViewController: UIViewController {
    
    weak var coordinator: AppCoordinatorDelegate?
    
   
    
    @IBOutlet var bg: UIView!
    let mainColor = UIColor(named: "mainColor")
    let mainColorInvert = UIColor(named: "mainColorInvert")
    @IBOutlet var background: UIView!
    @IBOutlet weak var launchImage: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    var alreadyPlayed: Bool = false
    
    
    
    
    override func viewDidLoad() {
        print(alreadyPlayed)
        super.viewDidLoad()
        bg.backgroundColor = mainColorInvert
        startButton.layer.cornerRadius = 30
        launchImage.setAnchorPoint(CGPoint(x: 0.5, y: 0))
        launchImage.transform = CGAffineTransform(rotationAngle: -0.30)
        launchImage.pendum()
        
        
   
        
        // Do any additional setup after loading the view.
    }
    
    

    @IBAction func didPress(_ sender: Any) {
    
        alreadyPlayed = true
        let quizzStatus = QuizzStatus(questions: QuestionsRepository.shared.questions)
        
        coordinator?.presentQuizz(item: quizzStatus)
    
    }
    
}



