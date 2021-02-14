//
//  ViewController.swift
//  ObjectFormExample
//
//  Created by Jake on 2/29/20.
//  Copyright © 2020 Jake. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    let datePicker = UIDatePicker()
    let dateCreated = Date()
    let formatter = DateFormatter()
    var cellText = FieldTableViewCell()
    
    private var dateList = [""]

    private var lifeguardList = [
        LifeGuard(name: "", station: "", place: "", alarmed: "", equipment: "", extaHelp: "")
     
    ]
    private var rescuedList = [
        Rescued(name: "", age: "", signe: "", found: "", swim: "", unconscious: "")
    ]
    
    private var accidentList = [
            Accident(accident: "", type: "", yourProc: "", procedure: "")
    ]

    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .systemGray6
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Report"

        tableView.dataSource = self
        tableView.delegate = self
        
        self.datePicker.preferredDatePickerStyle = UIDatePickerStyle.wheels
        
        
      
        
        // date format style
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        
        // register custom cell
        tableView.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        
        

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
//        for i  in fruitList {
//            print(i.alarmed, i.equipment )
//        }
       
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
            
            
            
        }else if indexPath.section == 1{
            let lifeguard = lifeguardList[indexPath.row]
            let fruitFormVC = FromLifeGuardVC(lifeguard)
            self.navigationController?.pushViewController(fruitFormVC, animated: true)
            
        }else if indexPath.section == 2{
            let rescued = rescuedList[indexPath.row]
            let fruitFormVC = FromRescuedVC(rescued)
            self.navigationController?.pushViewController(fruitFormVC, animated: true)
            
        }else if indexPath.section == 3{
            let accident = accidentList[indexPath.row]
            let fruitFormVC = FromAccidentVC(accident)
            self.navigationController?.pushViewController(fruitFormVC, animated: true)
            
        }
        
        
        
    }
   
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            return dateList.count
            
        }else if section == 1{
            
            return lifeguardList.count
        }else if section == 2{
            
            return rescuedList.count
        }else {
            
            return accidentList.count
        }
        
        

        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
//        cell.textLabel?.text = fruitList[indexPath.row].name
//        cell.detailTextLabel?.text = fruitList[indexPath.row].name
        
        
        if indexPath.section == 0 {
//            cell.textLabel?.text = "date"
            
//            cell.imageView?.image = UIImage(systemName: "calendar.badge.clock")
           
            
//             note
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell

            // set custom cell as delegate
            fieldCell.field.delegate = self
            fieldCell.field.placeholder = "Date"
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
            
            
            
      
            return fieldCell
        
        
          
            
        }else if indexPath.section == 1{
            cell.textLabel?.text = "LifeGuard info"
            cell.detailTextLabel?.text = lifeguardList[indexPath.row].name
            cell.imageView?.image = UIImage(systemName: "person")
            
        }else if indexPath.section == 2{
            cell.textLabel?.text = "Rescued info"
            cell.detailTextLabel?.text = rescuedList[indexPath.row].name
            cell.imageView?.image = UIImage(systemName: "staroflife")
            
        }else if indexPath.section == 3{
            cell.textLabel?.text = "Accident And Procedure"
            cell.detailTextLabel?.text = accidentList[indexPath.row].type
            cell.imageView?.image = UIImage(systemName: "cross.case")
        }else if indexPath.section == 4{
            
        }else if indexPath.section == 5{
          
        }
        
        
        
        return cell
    }
    
  
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date"
        }else if  section == 1{
            return "Basic info"
        }else if  section == 2{
            return "Rescued info"
        }else if  section == 3{
            return "Accident And Procedure"
        }else{
            return "Descibe"
        }
        
    }

    
    
    
    
    
    
    @objc func doneDatePressed() {
        cellText.field.text = formatter.string(from: datePicker.date)
        cellText.field.resignFirstResponder()
       
    }
    
    @objc func todayDatePressed() {
        cellText.field.text = formatter.string(from: Date())
        cellText.field.resignFirstResponder()
       
    }

}
