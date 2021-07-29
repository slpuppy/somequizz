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
    
    weak var coordinator: AppCoordinatorDelegate?
    var questionItem: Question?
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet var background: UIView!
    @IBOutlet weak var answerButton2: UIButton!
    @IBOutlet weak var answerButton3: UIButton!
    @IBOutlet weak var questionNum: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var questImage: UIImageView!
    
    let nextQuestion = Question(question: "When did time begin?", questionNum: "Second question", answer1: "before it's existence", answer2: "when clocks were invented", answer3: "I don't know", questionImage: "infinitecircle", rightAnswer: "before it's existence")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateInfo()
        setupStyles()
        questImage.rotate()
        
        
    }
    
    
    @IBAction func didPress(_ sender: Any) {
        
        
        
        self.coordinator?.presentQuizz(item: nextQuestion)
        
        
    }
    
    func updateInfo() {
        questionLabel.text = questionItem?.question
        questionNum.text = questionItem?.questionNum
        answerButton.setTitle(questionItem?.answer1, for: .normal)
        answerButton2.setTitle(questionItem?.answer2, for: .normal)
        answerButton3.setTitle(questionItem?.answer3, for: .normal)
        questImage.image = UIImage(named: "\(questionItem!.questionImage)")
        
        
    }
    
    func setupStyles() {
        
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
    
    
}

extension UIView{
    func rotate() {
        let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotation.toValue = NSNumber(value: Double.pi * 2)
        rotation.duration = 3.5
        rotation.isCumulative = true
        rotation.repeatCount = Float.greatestFiniteMagnitude
        self.layer.add(rotation, forKey: "rotationAnimation")
        
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
