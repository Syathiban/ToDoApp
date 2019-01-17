//
//  ListViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 25.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase
class ListViewController: UIViewController, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate{
    
    
    
    
    
    var ref: DatabaseReference!
    var databaseHandle : DatabaseHandle!
    var tasks = [String]()
    var cell = UITableViewCell()
    
    @IBOutlet weak var home: UIButton!
    
    @IBOutlet weak var taskView: UITableView!
    @IBOutlet weak var categoryPicker: UIPickerView!
    
    
    var error: NSError?
    var categories = [String]()
    
    var myIndex = 0
    var indexRow = 0
    var ID = ""
    var hey = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        home.isHighlighted = true
        taskView.delegate = self
        taskView.dataSource = self
        taskView.register(UITableViewCell.self, forCellReuseIdentifier: "tblCellNote")
        print("hulumo")
        taskView.reloadData()
        tasks = Tasks.shared.getTasks()
        tasks.remove(at: 0)
        
        setCategories()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskView.reloadData()
        
    }
    
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        cell = tableView.dequeueReusableCell(withIdentifier: "tblCellTask", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        
        let switchObj = UISwitch(frame: CGRect(x: 1, y: 1, width: 20, height: 20))
        switchObj.isOn = false
        switchObj.addTarget(self, action: #selector(toggle(_:)), for: .valueChanged)
        
        cell.accessoryView = switchObj
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tasks[indexPath.row] != "" {
                self.myIndex = indexPath.row
                IndexofRow.shared.addIndex(myIndex: self.myIndex)
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
                        var dateT = (value?["Date"] as? String)!
                        var descrip = (value?["Description"] as! String)
                        Tasks.shared.setSingleDate(dateT: dateT)
                        Tasks.shared.setSingleDescript(descrip: descrip)
                        
                    })
                    
                }
                
            })
            
            
            
        }else{
            print("sorry its empty")
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let screen = self.storyboard?.instantiateViewController(withIdentifier: "Task") as? TaskViewController
            self.present(screen!, animated: true, completion: nil)
        }
        
//          performSegue(withIdentifier: "segue", sender: self)
        
        
    }
    
    @objc func toggle(_ sender: UISwitch) {
        let alertController = UIAlertController(title: "Note!", message: "Are you sure that you have completed it. (It will be deleted)", preferredStyle: .alert)
        let indexPath = self.taskView.indexPath(for: cell)
        myIndex = indexPath!.row
        IndexofRow.shared.addIndex(myIndex: myIndex)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            
            self.ref = Database.database().reference()
            let userID : String = (Auth.auth().currentUser?.uid)!
            print("Current user ID is: " + userID)
            
            
            let ref = self.ref.child(userID).child(Tasks.shared.getCat()).child(Tasks.shared.getTaskID())
            
            ref.removeValue { error, _ in
                
                self.setCategories()
                self.tasks.remove(at: indexPath!.row)
                self.taskView.reloadData()
        }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
            self.taskView.reloadData()
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            self.tasks.remove(at: indexPath.row)
            self.ref = Database.database().reference()
            let userID : String = (Auth.auth().currentUser?.uid)!
            print("Current user ID is: " + userID)


            let ref = self.ref.child(userID).child(Tasks.shared.getCat()).child(Tasks.shared.getTaskID())

            ref.removeValue { error, _ in

                print("Has it worked")

                self.taskView.reloadData()

        }
            self.setCategories()
        
    }
        
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            self.myIndex = indexPath.row
            IndexofRow.shared.addIndex(myIndex: self.myIndex)
            self.performSegue(withIdentifier: "goToEdit", sender: self)
            print("edited")
        }
        edit.backgroundColor = UIColor(red: 48/255, green: 123/255, blue: 246/255, alpha: 100)
        return [delete, edit]


}
    
    func setCategories() {
        ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("Current user ID is: " + userID)
        ref.child(userID).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            
            if value !== nil {
                var keys:[String] = value!.allKeys as! [String]
                //                self.standard.set(keys, forKey: "SavedCategories")
                keys.insert(self.ID, at: keys.startIndex)
                Tasks.shared.setCategories(categories: keys)
            }
        })
    }
}
