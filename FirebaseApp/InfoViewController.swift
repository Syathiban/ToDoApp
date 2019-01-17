//
//  InfoViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 25.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase

class InfoViewController: UIViewController {
    
   
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tasks.shared.deleteTasks()
        Tasks.shared.deleteCat()
        Tasks.shared.deleteCategories()
        addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        let up = UISwipeGestureRecognizer(target : self, action : #selector(InfoViewController.upSwipe))
        up.direction = .up
        self.view.addGestureRecognizer(up)
    }
    
    @objc
    func upSwipe(){
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(screen!, animated: false, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewWillLayoutSubviews()
        gradient.frame = view.layer.bounds
        
    }
    
    
    @IBAction func goToList(_ sender: Any) {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(screen!, animated: false, completion: nil)
    }
    
    func addVerticalGradientLayer(topColor:UIColor, bottomColor:UIColor) {
        gradient.frame = view.bounds
        gradient.colors = [
            topColor.cgColor,
            bottomColor.cgColor
        ]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 0, y: 1)
        view.layer.insertSublayer(gradient, at: 0)
        
    }

}
