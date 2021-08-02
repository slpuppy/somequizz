//
//  QuizzViewController.swift
//  somequizz
//
//  Created by Gabriel Puppi on 28/07/21.
//

import UIKit

class QuizzViewController: UIViewController {
    
    let mainColor = UIColor(named: "mainColor")
    let mainColorInvert = UIColor(named: "mainColorInvert")
    let mainGreen = UIColor(named: "mainGreen")
    let mainRed = UIColor(named: "mainRed")
    weak var coordinator: AppCoordinatorDelegate?
    var quizzStatus: QuizzStatus?
    var currentQuestion: Question?
    
    
    
    var rightAnswer: String = ""
    
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var questImage: UIImageView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    
    var circleAnimations = ["First", "Fifth", "Sixth", "Seventh", "Eight", "Real"]
    var penduAnimations = ["Second", "Third","Fourth", "Nineth", "Fake"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentQuestion = quizzStatus!.questions.removeFirst()
        rightAnswer = currentQuestion!.rightAnswer
        updateInfo()
        setupStyles()
        for i in circleAnimations {
            if questionNum.text!.contains(i) {
                questImage.rotate()
            }
        }
        for i in penduAnimations {
             if questionNum.text!.contains(i) {
                questImage.setAnchorPoint(CGPoint(x: 0.5, y: 0.2))
                questImage.transform = CGAffineTransform(rotationAngle: -0.30)
                questImage.pendum()
            }
        }
  }
func presentNextQuestion() {
        guard !quizzStatus!.questions.isEmpty else {
            
            coordinator?.presentEnd(item: quizzStatus! )
            
            print("ACERTOS: \(quizzStatus!.rightCount)")
            print("ERROS: \(quizzStatus!.wrongCount)")
            return
            }
        coordinator?.presentQuizz(item: quizzStatus!) // Vai apresentar o próximo quiz e o quizStatus vai ter uma question a menos
    }
    
    
    @IBAction func didPress(_ sender: UIButton!) {
        revealAnwswer()
        if sender.currentTitle == rightAnswer {
            revealAnwswer()
            quizzStatus?.rightCount += 1
            sender.isHighlighted = true 
            sender.backgroundColor = mainGreen
            sender.layer.opacity = 1.0
            
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presentNextQuestion()
            }
        } else {
            revealAnwswer()
            quizzStatus?.wrongCount += 1
            sender.isHighlighted = true
            sender.layer.opacity = 1.0
            sender.backgroundColor = mainRed
            sender.layer.opacity = 1.0
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.presentNextQuestion()
            }
        }
    }
    
    func updateInfo() {
        
        questionLabel.text = currentQuestion?.question
        questionNum.text = currentQuestion?.questionNum
        answerButton.setTitle(currentQuestion?.answer1, for: .normal)
        answerButton2.setTitle(currentQuestion?.answer2, for: .normal)
        answerButton3.setTitle(currentQuestion?.answer3, for: .normal)
        questImage.image = UIImage(named: "\(currentQuestion!.questionImage)")
        
    }
    
    func setupStyles() {
        
        questionLabel.sizeToFit()
        questionLabel.font = .systemFont(ofSize: 28, weight: .semibold)
        questionLabel.textColor = mainColor
        questionNum.textColor = mainColor
        answerButton.layer.borderWidth = 1.0
        answerButton2.layer.borderWidth = 1.0
        answerButton3.layer.borderWidth = 1.0
        answerButton.layer.borderColor = mainColor?.cgColor
        answerButton2.layer.borderColor = mainColor?.cgColor
        answerButton3.layer.borderColor = mainColor?.cgColor
        answerButton.layer.cornerRadius = 30
        answerButton2.layer.cornerRadius = 30
        answerButton3.layer.cornerRadius = 30
        answerButton.titleLabel?.textAlignment = .left
        answerButton2.titleLabel?.textAlignment = .left
        
        
    }
    
    func revealAnwswer() {
        answerButton.layer.borderWidth = 0.0
        answerButton2.layer.borderWidth = 0.0
        answerButton3.layer.borderWidth = 0.0
        answerButton.backgroundColor = .white
        answerButton.layer.opacity = 0.7
        answerButton2.backgroundColor = .white
        answerButton2.layer.opacity = 0.7
        answerButton3.backgroundColor = .white
        answerButton3.layer.opacity = 0.7
        answerButton.isEnabled = false
        answerButton2.isEnabled = false
        answerButton3.isEnabled = false
        
        
    }
    
    func changeAnimation(){
        
        
        
        questImage.pendum()
        
        
        
    }
    
}

extension UIView{
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 4.0
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
        
    }
}

extension UIView{
    func pendum() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: .pi * 0.1)
        rotation.duration = 2.0
        rotation.autoreverses = true
        rotation.isCumulative = false
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
        
    }
}

extension UIView {
    func setAnchorPoint(_ point: CGPoint) {
        var newPoint = CGPoint(x: bounds.size.width * point.x, y: bounds.size.height * point.y)
        var oldPoint = CGPoint(x: bounds.size.width * layer.anchorPoint.x, y: bounds.size.height * layer.anchorPoint.y);
        
        newPoint = newPoint.applying(transform)
        oldPoint = oldPoint.applying(transform)
        
        var position = layer.position
        
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        layer.position = position
        layer.anchorPoint = point
    }
}


extension UIViewController {
    
    public func findLastPresentedViewController() -> UIViewController? {
        func findTopLevelViewController(_ viewController: UIViewController) -> UIViewController? {
            if let vc = viewController.presentedViewController {
                return findTopLevelViewController(vc)
            } else if let vc = viewController as? UISplitViewController  {
                if let vc = vc.viewControllers.last {
                    return findTopLevelViewController(vc)
                }
                return vc
            } else if let vc = viewController as? UINavigationController {
                if let vc = vc.topViewController {
                    return findTopLevelViewController(vc)
                }
                return vc
            } else if let vc = viewController as? UITabBarController {
                if let vc = vc.selectedViewController {
                    return findTopLevelViewController(vc)
                }
                return vc
            } else {
                return viewController
            }
        }
        
        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
            return findTopLevelViewController(rootViewController)
        }
        
        return nil
    }
    
}
