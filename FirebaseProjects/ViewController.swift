//
//  ViewController.swift
//  FirebaseProjects
//
//  Created by Mustafa on 10/17/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    let db = Firestore.firestore()

    

    let typeOFcars = ["Suv", "Truck","Sedan","Van","Coupe","Wagon","Sport Car","Diesel","Luxury Car","Hybrid","Crossover"]
    
    @IBOutlet weak var itemsTableView: UITableView!
    
    
    @IBOutlet weak var categoryDataPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryDataPicker.isHidden = true
        itemsTableView.dataSource = self
        itemsTableView.delegate = self
        categoryDataPicker.delegate = self
        categoryDataPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    
    


    @IBAction func showPickerPressed(_ sender: UIButton) {
        categoryDataPicker.isHidden = !categoryDataPicker.isHidden
    }
}

extension ViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return typeOFcars.count
    }
    
    
}

extension ViewController : UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return typeOFcars[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        
        //TO DO:  Firebase colud and save it in our database

        // Add a new document with a generated ID
        
        var ref: DocumentReference? = nil
        ref = db.collection("cars").addDocument(data: [
            "typeofcar": typeOFcars[row],
            "comment": "ok ok ok ",
           
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        

        
        
        
        //TO DO:  Firebase realTime and save it in our database
        
//        let messagesDB = Database.database().reference().child("DataOfCar")
//        let messageDictionary = ["Sender" :  typeOFcars[row] , "MessageBody" :"news a good"]
//
//        messagesDB.childByAutoId().setValue(messageDictionary){
//            (error , reference) in
//            if error != nil {
//                print(error!)
//            }else {
//                print("Message Saved Successfull")
//
//            }
//        }
    
    

    }

    
    
}
extension ViewController : UITableViewDelegate {
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeOFcars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        
        return cell
        
    }
    
    
}



/*
 service cloud.firestore {
 match /databases/{database}/documents {
 match /{document=**} {
 allow read, write: if false;
 }
 }
 }
 */
