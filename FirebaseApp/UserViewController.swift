//
//  UserViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 27.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase

class UserViewController: UIViewController {

    let gradient = CAGradientLayer()
        
    @IBOutlet weak var toolbar: UIView!
    @IBOutlet var userView: UIView!
    
    override func viewDidLoad() {
            super.viewDidLoad()
        let model = UIDevice.current.model
        if model == "iPhone" {
            toolbar.isHidden = false
        } else {
            toolbar.isHidden = true
        }
        }
        
        override func viewDidLayoutSubviews() {
            super.viewWillLayoutSubviews()
            gradient.frame = view.layer.bounds
            
            
        }
        
    
    
    
    
    @IBAction func handleSignOut(_ sender: Any) {
        try! Auth.auth().signOut()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Start") as! MenuViewController
        self.present(controller, animated: true, completion: nil)
    }
    
}
