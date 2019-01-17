//
//  Tasks.swift
//  FirebaseApp
//
//  Created by Athiban on 26.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import Foundation
import Firebase

// Everything that has to do with the Tasks are done with this Class.
class Tasks {
    static let shared = Tasks()
    var tasks = [String]()
    var date = [String]()
    var descript = [String]()
    let defaults = UserDefaults.standard
    let standard = UserDefaults.standard
    let normal = UserDefaults.standard
    let bor = UserDefaults.standard
    var ref: DatabaseReference!
    var error: NSError?
    var ID = ""
    var cats = [""]
    
    private init() {
        
    }
    
    func addTasks(task: String) {
        tasks.append(task)
        defaults.set(tasks, forKey: "SavedArray")
    }
    
    
    func getTasks() -> [String] {
        let tasks2 = defaults.object(forKey:"SavedArray") as? [String] ?? [String]()
        tasks = tasks2
        print("seufz", tasks)
        return tasks
    }
    
    func getTaskID() -> String{
        let taskIDs = defaults.object(forKey:"TasIDs") as? [String] ?? [String]()
        var index = IndexofRow.shared.getIndex()
        ID = taskIDs[index]
        return ID
    }
    
    
    func deleteTasks() {
        tasks = [""]
        defaults.set(tasks, forKey: "SavedArray")
    }
    
    func getCat() -> String {
        let cat2 = defaults.object(forKey: "category") as! String
        
        return cat2
    }
    
    func setCategories(categories: [String]) {
        
        standard.set(categories, forKey: "SavedCategories")
    }
    
    func getCategories() -> [String] {
        let category = standard.object(forKey:"SavedCategories") as? [String] ?? [String]()
        return category
    }
    
    
    
    
    func setSingleDescript(descrip: String) {
        descript.append(descrip)
        normal.set(descrip, forKey: "SavedDescrip")
        
    }
    
    func setSingleDate(dateT: String) {
       date.append(dateT)
        print("hallo:", date)
       bor.set(dateT, forKey: "SavedDate")
    }
    
    func deleteValues() {
        var date = ""
        var descript = ""
        bor.set(date, forKey: "SavedDate")
        normal.set(descript, forKey: "SavedDescrip")
    }
    
    func getSingleDescript() -> String {
        let descripT = normal.object(forKey:"SavedDescrip") as? String
        return descripT!
    }
    
    func getSingleDate() -> String {
        let dateF = bor.object(forKey:"SavedDate") as? String
        return dateF!
    }
    
    func deleteCategories() {
        cats = [""]
        standard.set(cats, forKey: "SavedCategories")
    }
    
    func deleteCat() {
        let king = [""]
        defaults.set(king, forKey: "category")
    }
    
    func getDate() -> String {
        let date = self.defaults.object(forKey: "Date") as! String
        return date
    }
    
    func getDescription() -> String {
         let descript = defaults.object(forKey: "description") as! String
        return descript
    }
    
    func saveCategory(category: String) {
        defaults.set(category, forKey: "category")
        ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        ref.child(userID).child(category).observeSingleEvent(of: .value, with: { snapshot in
            let value = snapshot.value as? NSDictionary
            
            if value !== nil {
                let keys:[String] = value!.allKeys as! [String]
                self.defaults.set(keys, forKey: "TasIDs")
                for Key in keys {
                    self.ref.child(userID).child(category).child(Key).observeSingleEvent(of: .value, with: { snapshot in
                        
                        if !snapshot.exists() { return }
                        
                        
                        let value = snapshot.value as? NSDictionary
                        let task = value?["Task"] as? String
                        self.addTasks(task: task!)
                        
                    })
                    
                }
                
            }
            
        })
        
    }
    
}
