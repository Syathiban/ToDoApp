//
//  EditViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 29.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase

class EditViewController: UIViewController {

    let defaults = UserDefaults.standard
    var ref: DatabaseReference!
    var error: NSError?
    var dateU = ""
    var Task = ""
    var Cat = ""
    var descrip = ""
    var timeFormatter = DateFormatter()
    var dat = ""
    
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var descript: UITextView!
    @IBOutlet weak var date: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        var index = IndexofRow.shared.getIndex()
        var taskArray = Tasks.shared.getTasks()
        taskArray.remove(at: 0)
        taskName.text = taskArray[index]
        categoryName.text = Tasks.shared.getCat()
        
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let category = Tasks.shared.getCat()
        let key = Tasks.shared.getTaskID()
        ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        ref.child(userID).child(category).child(key).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            if value !== nil {
                
                self.ref.child(userID).child(category).child(key).observeSingleEvent(of: .value, with: { snapshot in
                    
                    if !snapshot.exists() { return }
                    
                    
                    let value = snapshot.value as? NSDictionary
                    let dateT = (value?["Date"] as? String)!
                    let descrip = (value?["Description"] as! String)
                    self.defaults.set(dateT, forKey: "Date")
                    self.descript.text = descrip
                    
                })
                
            }
            
        })
        
        
    }
    
    @IBAction func editTask(_ sender: Any) {
        Tasks.shared.deleteTasks()
        Task = taskName.text!
        print("Task ist: ", Task)
        Cat = categoryName.text!
        descrip = descript.text!
        let taskId = Tasks.shared.getTaskID()
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        var selectedDate = dateFormatter.string(from: date.date)
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("Current user ID is: " + userID)
        
        self.ref.child(userID).child(Cat).child(taskId).setValue(["Task" : Task, "Description" : descrip, "Date" : selectedDate])
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
        let transition = CATransition()
        transition.duration = 0.0
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(screen!, animated: false, completion: nil)
    }
    
    
    @IBAction func back(_ sender: Any) {
        let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
                let transition = CATransition()
                transition.duration = 0.0
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromBottom
                view.window!.layer.add(transition, forKey: kCATransition)
                self.present(screen!, animated: false, completion: nil)
    }
    
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    


}
