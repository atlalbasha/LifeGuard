//
//  AddIncidentViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-29.
//

import UIKit
import RealmSwift


class AddIncidentViewController: UIViewController {
    
    let realm = try! Realm()
    var incidents: Results<AddIncident>?
    
    let dateCreated = Date()
    let formatter = DateFormatter()
    
    
    
    
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var personText: UITextField!
    @IBOutlet weak var placeText: UITextField!
    @IBOutlet weak var accidentText: UITextField!
    @IBOutlet weak var procedureText: UITextField!
    
    let datePicker = UIDatePicker()
    let dataPicker = UIPickerView()
    
    var donePersonInfo: String = ""
    let infoPerson = ["Old Man", "Old Woman", "Man", "Woman", "Young Boy", "Young Girl", "Little Boy", "Little Girl"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataPicker.delegate = self
        dataPicker.dataSource = self
        personText.inputView = dataPicker
        
        dateText.delegate = self
        nameText.delegate = self
        personText.delegate = self
        placeText.delegate = self
        accidentText.delegate = self
        procedureText.delegate = self
        
        
        // Set datePicker style and call method
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        createDatePicker()
        createDataPicker()
        
        // date format style
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        
        
    }
    
    
    
    
    // cancel pressed
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // save pressed
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        
        let newIncident = AddIncident()
        newIncident.date = Date()
        newIncident.name = nameText.text!
        newIncident.person = personText.text!
        newIncident.place = placeText.text!
        newIncident.accident = accidentText.text!
        newIncident.procedure = procedureText.text!
        
        saveIcident(incident: newIncident)
        
        //  back to previous page and refresh tableView with segue
        self.performSegue(withIdentifier: "backInciSegue", sender: self)
        
        
    }
    
    // MARK: - Navigation
    
    
    // Pass the selected object to the new view controller.
    //    override func performSegue(withIdentifier identifier: String, sender: Any?) {
    //        performSegue(withIdentifier: "backInciSegue", sender: self)
    //    }
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if segue.identifier == "backInciSegue"{
    //            let destinationVC = segue.destination as! IncidentsTableViewController
    //
    //            if let incid = incidents{
    //            destinationVC.addedIncident = incidents?
    //        }
    //        }
    //
    //
    //
    //    }
    
    
    
    
    
    //MARK: - save and load incident
    
    func saveIcident(incident: AddIncident) {
        do {
            try realm.write{
                realm.add(incident)
            }
        } catch {
            print("Error saving item, \(error)")
        }
    }
    
    //MARK: - Date Picker
    
    func createDatePicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let todayPressed = UIBarButtonItem(title: "Now", style: .plain, target: nil, action: #selector(todayDatePressed))
        let donePressed = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([donePressed, flexibleSpace ,todayPressed], animated: true)
        
        dateText.inputAccessoryView = toolbar
        dateText.inputView = datePicker
    }
    
    @objc func doneDatePressed() {
        
        dateText.text = formatter.string(from: datePicker.date)
        dateText.resignFirstResponder()
    }
    
    @objc func todayDatePressed() {
        
        dateText.text = formatter.string(from: Date())
        dateText.resignFirstResponder()
    }
    
    func createDataPicker() {
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let donePressed = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDataPressed))
        
        let cancelPressed = UIBarButtonItem(barButtonSystemItem: .cancel, target: nil, action: #selector(cancelDataPressed))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        toolbar.setItems([cancelPressed, flexibleSpace ,donePressed], animated: true)
        toolbar.isUserInteractionEnabled = true
        
        
        personText.inputView = dataPicker
        personText.inputAccessoryView = toolbar
        
        
    }
    
    
}





// MARK: - Person Data Picker



extension AddIncidentViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return infoPerson.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        return infoPerson[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        donePersonInfo = infoPerson[row]
        
//        personText.text = infoPerson[row]
        
        //        personText.resignFirstResponder()
        
    }
    @objc func doneDataPressed() {
        personText.text = donePersonInfo
        personText.resignFirstResponder()
        
    }
    
    @objc func cancelDataPressed() {
        personText.resignFirstResponder()
    }
    
}


//MARK: - TextField delegate

extension AddIncidentViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}






