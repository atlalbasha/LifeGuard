//
//  AddIncidentTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-09.
//

import UIKit

class AddIncidentTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    let datePicker = UIDatePicker()
    let dateCreated = Date()
    let formatter = DateFormatter()
    var cellText = FieldTableViewCell()
    
    var nameText = ""
    var personText = ""
    var placeText = ""
    var accidentText = ""
    var procText = ""
    
    let date = ["Date"]
    let name = ["LifeGuard Name"]
    let person = ["Person info"]
    let place = ["Place"]
    let accident = ["Accident"]
    let procueder = ["Procuder"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
        // date format style
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        // register custom cell
        tableView.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return date.count
        }else if section == 1 {
            return name.count
        }else if section == 2 {
            return person.count
        }else if section == 3 {
            return place.count
        }else if section == 4 {
            return accident.count
        }else {
            return procueder.count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date"
        }else if section == 1 {
            return "LifeGuard"
        }else if section == 2 {
            return "Rescued"
        }else if section == 3 {
            return "Place"
        }else if section == 4 {
            return "Accident"
        }else {
            return "Procueder"
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        _ = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        
        // note
        let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
        fieldCell.field.delegate = self
        
        
        // date
        if indexPath.section == 0{
            
            // set custom cell as delegate
            
            fieldCell.field.placeholder = "date"
            fieldCell.imageView?.image = UIImage(systemName: "calendar.badge.clock")
            fieldCell.field.textAlignment = .center
            
            let toolbar = UIToolbar()
            toolbar.sizeToFit()
            
            let todayPressed = UIBarButtonItem(title: "Now", style: .plain, target: nil, action: #selector(todayDatePressed))
            let donePressed = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneDatePressed))
            let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            
            toolbar.setItems([donePressed, flexibleSpace ,todayPressed], animated: true)
            
            fieldCell.field.inputAccessoryView = toolbar
            
            fieldCell.field.inputView = datePicker
            
            cellText = fieldCell
            
            
            // lifeguard
        }else if indexPath.section == 1{
            
            
            
            
            fieldCell.field.placeholder = "type your name..."
            fieldCell.tag = indexPath.row
            fieldCell.imageView?.image = UIImage(systemName: "person")
            fieldCell.field.textAlignment = .center
            
            nameText = fieldCell.field.text!
            
            
            
            // preson
        }else if indexPath.section == 2{
            
            
            
            fieldCell.field.placeholder = "rescued Age, Gender"
            fieldCell.tag = 2
            fieldCell.imageView?.image = UIImage(systemName: "staroflife")
            fieldCell.field.textAlignment = .center
            
            personText = fieldCell.field.text!
            
            //place
        }else if indexPath.section == 3{
            
            fieldCell.field.placeholder = "incident place.."
            fieldCell.tag = indexPath.row
            fieldCell.imageView?.image = UIImage(systemName: "paperplane")
            fieldCell.field.textAlignment = .center
            
            placeText = fieldCell.field.text!
            
            //Accident
        }else if indexPath.section == 4{
            
            
            fieldCell.field.placeholder = "typ of accident"
            fieldCell.tag = indexPath.row
            fieldCell.imageView?.image = UIImage(systemName: "cross")
            fieldCell.field.textAlignment = .center
            
            accidentText = fieldCell.field.text!
            
            //proceuder
        }else {
            
            fieldCell.field.placeholder = "proceuder"
            fieldCell.tag = indexPath.row
            fieldCell.imageView?.image = UIImage(systemName: "cross.case")
            fieldCell.field.textAlignment = .center
            
            procText = fieldCell.field.text!
            
        }
        return fieldCell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
    @objc func doneDatePressed() {
        cellText.field.text = formatter.string(from: datePicker.date)
        cellText.field.resignFirstResponder()
        
    }
    
    @objc func todayDatePressed() {
        cellText.field.text = formatter.string(from: Date())
        cellText.field.resignFirstResponder()
        
    }
    
    //MARK: - TextField
    
    // text field end and return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        tableView.reloadData()
        textField.resignFirstResponder()
        return true
    }
    
    
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        tableView.reloadData()
        print(nameText)
        print(placeText)
        print(personText)
        print(accidentText)
        print(procText)
    }
    
    
}
