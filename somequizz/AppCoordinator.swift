//
//  AppCoordinator.swift
//  somequizz
//
//  Created by Gabriel Puppi on 28/07/21.
//

import UIKit


protocol AppCoordinatorDelegate: AnyObject {
    
    func presentStart()
    
    func presentQuizz(item: QuizzStatus)
    
    func presentEnd(item: QuizzStatus)
    
}



class AppCoordinator {
    
    weak var window: UIWindow?
    var state: AppCoordinatorState?
    var navVC: UINavigationController?
    
    init(window: UIWindow) {
        
        self.window = window
        navVC = UINavigationController()
        window.rootViewController = navVC
        
        navVC?.setNavigationBarHidden(true, animated: false)
        
    }
    
    
    func start() {
        
        presentStart()
        
    }
    
    func createStartVC() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? MainViewController else {
            
            fatalError()
            
        }
        
        vc.coordinator = self
        return vc
    }
    
    func createQuizzVC(item: QuizzStatus) -> QuizzViewController {
        
        let storyboard = UIStoryboard(name: "Quizz", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? QuizzViewController else {
            
            fatalError()
        }
        
        vc.quizzStatus = item
        return vc
        
        
    }
    
    func createEndVC(item: QuizzStatus) -> EndViewController {
        let storyboard = UIStoryboard(name: "End", bundle: nil)
        guard let vc = storyboard.instantiateInitialViewController() as? EndViewController else {
            
            fatalError()
        }
        
        vc.quizzStatus = item
        return vc
       }
        
    }
    
    
    


extension AppCoordinator: AppCoordinatorDelegate {
    
    
    func presentEnd(item: QuizzStatus) {
        let endVC = createEndVC(item: item)
        endVC.modalPresentationStyle = .fullScreen
        navVC?.pushViewController(endVC, animated: true)
        state = .end
        
        endVC.coordinator = self
    }
    
    
    
    
    func presentQuizz(item: QuizzStatus) {
        
        let quizzVC = createQuizzVC(item: item)
        quizzVC.modalPresentationStyle = .fullScreen
        navVC?.pushViewController(quizzVC, animated: true)
        state = .quizz
        
        quizzVC.coordinator = self
    }
    
    
    
 
    
    
    func presentStart() {
        guard state != .start else { return }
        let startVC = createStartVC()
        navVC?.pushViewController(startVC, animated: true)
        state = .start
    }
    
    
}







enum AppCoordinatorState {
    
    case start
    case quizz
    case end
    
    
    
}
