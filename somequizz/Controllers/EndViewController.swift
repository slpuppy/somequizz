//
//  EndViewController.swift
//  somequizz
//
//  Created by Gabriel Puppi on 01/08/21.
//

import UIKit

class EndViewController: UIViewController {
    
    @IBOutlet weak var firstLine: UILabel!
    @IBOutlet weak var secondLine: UILabel!
    @IBOutlet weak var endImage: UIImageView!
    @IBOutlet weak var scoreText: UILabel!
    @IBOutlet weak var scoreSub: UILabel!
    @IBOutlet weak var resultText: UILabel!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var lastText: UILabel!
    weak var coordinator: AppCoordinatorDelegate?
    var quizzStatus: QuizzStatus?
    
    
    
    
    
    override func viewDidLoad() {
        
        self.resetButton.layer.cornerRadius = 30
        endImage.rotate()
        updateResultInfo()
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func pressed(_ sender: Any) {
        
        self.coordinator?.presentStart()
        
    }
    
    
    
    func updateResultInfo() {
        
        
        
        switch quizzStatus?.rightCount {
        
        case 1,2,3,4,5,6,7,8:
            
            self.firstLine.text = "You tried so hard and got so far"
            self.secondLine.text = "but in the end..."
            self.scoreText.text = "Scored \(quizzStatus!.rightCount)/\(quizzStatus!.totalQuestion) stranger..."
            self.scoreSub.text = "and because this quizz is strange, unfortunatelly..."
            self.resultText.text = "You lost..."
            self.lastText.text = "but you can still..."
            self.resetButton.setTitle("Try again", for: .normal)
            
        case 9 :
            
            self.firstLine.text = "You tried so hard and got so far"
            self.secondLine.text = "and in the end..."
            self.scoreText.text = "Scored \(quizzStatus!.rightCount)/\(quizzStatus!.totalQuestion) stranger..."
            self.scoreSub.text = "and YOU LOST!, but fortunatelly..."
            self.resultText.text = "you found a secret:"
            self.lastText.text = "It was an inside job and this quizz is strange so..."
            self.resetButton.setTitle("Try again and win, you're close", for: .normal)
            
        case 10:
            
            self.firstLine.text = "You tried so hard and got so far"
            self.secondLine.text = "and in the end..."
            self.scoreText.text = "Scored \(quizzStatus!.rightCount)/\(quizzStatus!.totalQuestion) stranger..."
            self.scoreSub.text = "and because this quizz is strange, fortunatelly..."
            self.resultText.text = "You won!"
            self.lastText.text = "but you made one mistake..."
            self.resetButton.setTitle("Try to make none", for: .normal)
        
        case 11:
            
            self.firstLine.text = "You tried so hard and got so far"
            self.secondLine.text = "and in the end you completely nailed it!"
            self.scoreText.text = "Scored \(quizzStatus!.rightCount)/\(quizzStatus!.totalQuestion) stranger..."
            self.scoreSub.text = "and despite being a strange quizz you were"
            self.resultText.text = "Flawless"
            self.lastText.text = "this quizz isn't strange for you anymore"
            self.resetButton.setTitle("Replay", for: .normal)
            
        default:
            break
            
}
        
 }
    

   

}
