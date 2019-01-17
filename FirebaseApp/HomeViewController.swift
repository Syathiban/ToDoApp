//
//  HomeViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 25.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController:UIViewController {
    
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "info") as! InfoViewController
            self.present(controller, animated: true, completion: nil)
        }
    }
    

    
    
}
