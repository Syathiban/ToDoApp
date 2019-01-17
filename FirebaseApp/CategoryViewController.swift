//
//  CategoryViewController.swift
//  FirebaseApp
//
//  Created by Athiban on 27.12.18.
//  Copyright © 2018 Syamalla. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController {

    @IBOutlet weak var categoryPicker: UIPickerView!
    
    @IBOutlet weak var toolbar: UIView!
    var error: NSError?
    var categories = [String]()
    var ref: DatabaseReference!
    let standard = UserDefaults.standard
    let defaults = UserDefaults.standard
    var databaseHandle : DatabaseHandle!
    var selectedCategory = ""
    
    override func viewDidLoad() {
        let model = UIDevice.current.model
        if model == "iPhone" {
            toolbar.isHidden = false
        } else {
            toolbar.isHidden = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        super.viewDidLoad()
        }
        let category = Tasks.shared.getCategories()
        categories = category
        categoryPicker.delegate = self
        categoryPicker.dataSource = self
        categoryPicker.reloadAllComponents()
        
        
        
        // Do any additional setup after loading the view.
    }
    
   
    @IBAction func deleteCategory(_ sender: Any) {
        print("whyy")
        let userID : String = (Auth.auth().currentUser?.uid)!
        let cat = self.defaults.object(forKey: "category") as! String
      
        let alertController = UIAlertController(title: "Attention!", message: "All Tasks associated with this Category will be deleted too.", preferredStyle: .alert)
        
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
            UIAlertAction in
            Database.database().reference(withPath: userID).child(cat).removeValue()
            Tasks.shared.deleteTasks()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
        
    }
    
    
    
    @IBAction func Select(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.selectedCategory != "" {
                    let screen = self.storyboard?.instantiateViewController(withIdentifier: "list") as? ListViewController
                    self.present(screen!, animated: false, completion: nil)
               
            }else {
                let alert = UIAlertController(title: "Ohh!", message: "You didn't select anything.", preferredStyle: UIAlertController.Style.alert)
                
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                
                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
           
            
        }
    }
    
}

extension CategoryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = categories[row]
        defaults.set(selectedCategory, forKey: "category")
        if self.selectedCategory != "" {
            Tasks.shared.deleteTasks()
            Tasks.shared.saveCategory(category: selectedCategory)
        }
        
        
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categories[row]
    }
    
}
