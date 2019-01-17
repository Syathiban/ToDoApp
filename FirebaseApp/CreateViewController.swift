//
//  CreateViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 25.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase

class CreateViewController: UIViewController, UITextViewDelegate {
    
    
    @IBOutlet weak var Date: UIDatePicker!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var task: UITextField!
    
    
    @IBOutlet weak var toolbar: UIView!
    
    var Task = ""
    var Cat = ""
    var descrip = ""
    var timeFormatter = DateFormatter()
    var dat = ""
    var ref: DatabaseReference!
    var error: NSError?
    var ids = [String]()
    var cat = "Informatik"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = UIColor(red: 110/255, green: 67/255, blue: 241/255, alpha: 100)
        let model = UIDevice.current.model
        if model == "iPhone" {
            toolbar.isHidden = false
        } else {
            toolbar.isHidden = true
        }
        ref = Database.database().reference()
        textView.delegate = self
        let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        

        textView.text  = "Description type here.."
        textView.textColor = placeholdColor
       
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == placeholdColor {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text  = "Description type here.."
            textView.textColor = placeholdColor
        }
    }

    
    
    @IBAction func saveData(_ sender: Any) {
//        guard let userProfile = UserService.currentUserProfile else { return }
        
        Tasks.shared.deleteTasks()
        
        if task.text!.isEmpty || category.text!.isEmpty || textView.text!.isEmpty {
            let alert = UIAlertController(title: "Ohh!", message: "All Fields must be filled.", preferredStyle: UIAlertController.Style.alert)
            
            // action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // alert
            self.present(alert, animated: true, completion: nil)
        } else {
            Task = task.text!
            Cat = category.text!
            descrip = textView.text!
            var dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            var selectedDate = dateFormatter.string(from: Date.date)
            let userID : String = (Auth.auth().currentUser?.uid)!
            print("Current user ID is: " + userID)
            self.ref.child(userID).child(Cat).childByAutoId().setValue(["Task" : Task, "Description" : descrip, "Date" : selectedDate])
            let alert = UIAlertController(title: "Tip!", message: "Choose Category to See your Tasks.", preferredStyle: UIAlertController.Style.alert)
            
            // action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            
            // alert
            self.present(alert, animated: true, completion: nil)
            
            let model = UIDevice.current.model
            if model == "iPhone" {
                let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
                self.present(screen!, animated: false, completion: nil)
            } else {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "list") as! ListViewController
                self.present(controller, animated: false, completion: nil)
            }
        }
        
    }
    
   
    
}
