//
//  TaskViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 28.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase

class TaskViewController: UIViewController {

    let defaults = UserDefaults.standard
    var ref: DatabaseReference!
    var error: NSError?
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var descript: UITextView!
    @IBOutlet weak var date: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        taskName.isEnabled = false
        categoryName.isEnabled = false
        date.isEnabled = false
        var index = IndexofRow.shared.getIndex()
        var taskArray = Tasks.shared.getTasks()
        taskArray.remove(at: 0)
        taskName.text = taskArray[index]
        categoryName.text = Tasks.shared.getCat()
        date.text = Tasks.shared.getSingleDate()
        descript.text = Tasks.shared.getSingleDescript()
        var hund = Tasks.shared.getSingleDescript()
        print("hallo:", hund)
       
        
    }
    
    
    @IBAction func back(_ sender: Any) {
        Tasks.shared.deleteValues()
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(screen!, animated: false, completion: nil)
    }
    
    }
    

