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

    

    let typeOFcars = ["Suv", "Truck","Sedan","Van","Coupe","Wagon","Sport Car","Diesel","Luxury Car","Hybrid","Crossover"]
    var dataOfItems = [""]

    
    @IBOutlet weak var itemsTableView: UITableView!
    
    
    @IBOutlet weak var categoryDataPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readData()
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
    
    func readData()  {
        let db = Firestore.firestore()
        db.collection("cars").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    self.dataOfItems.append(document.documentID)
                    self.itemsTableView.reloadData()
                
                 //   print("\(document.documentID) => \(document.data())")
                    print(self.dataOfItems)
                    
                }
            }
        }
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

        
        //MARK :-   Firebase colud and save it in our database


        
        var ref: DocumentReference? = nil
        let db = Firestore.firestore()
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
        
        
    }

    
    
}
extension ViewController : UITableViewDelegate {
    
    
}

extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataOfItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
    cell.textLabel?.text = dataOfItems[indexPath.row]
        return cell
        
    }
    
    
}




