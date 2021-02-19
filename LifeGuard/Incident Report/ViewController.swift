//
//  ViewController.swift
//  ObjectFormExample
//
//  Created by Jake on 2/29/20.
//  Copyright © 2020 Jake. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    let realm = try! Realm()
    var addReport: Results<AddReport>?
    
    let datePicker = UIDatePicker()
    let dateCreated = Date()
    let formatter = DateFormatter()
    var cellText = FieldTableViewCell()
    
    private var dateList = [""]

    private var lifeguardList = [
        LifeGuard(name: "", station: "", place: "", alarmed: "", equipment: "", extraHelp: "")
     
    ]
    private var rescuedList = [
        Rescued(name: "", age: "", sign: "", found: "", swim: "", unconscious: "")
    ]
    
    private var accidentList = [
            Accident(accident: "", type: "", yourProc: "", procedure: "", improvement: "")
    ]

    private var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .insetGrouped)
        view.rowHeight = UITableView.automaticDimension
        view.backgroundColor = .systemGray6
        return view
    }()
    
    var reportDate = ""
    var lifeGuardName = ""
    var lifeStation = ""
    var place = ""
    var alarmed = ""
    var lifeEquipment = ""
    var extraHelp = ""
    var lifeNote = ""
    
    var rescuedName = ""
    var ageGender = ""
    var sign = ""
    var found = ""
    var swim = ""
    var unconscious = ""
    var rescuedNote = ""
    
    var disease = ""
    var procedure = ""
    var caseDescribe = ""
    var improvement = ""
    
    
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
        for i  in lifeguardList {
            
            lifeGuardName = i.name ?? ""
            lifeStation = i.station ?? ""
            place = i.place ?? ""
            alarmed = i.alarmed ?? ""
            lifeEquipment = i.equipment ?? ""
            extraHelp = i.extraHelp ?? ""
            lifeNote = i.note ?? ""
            
        }
        for i in rescuedList {
            
            rescuedName = i.name ?? ""
            ageGender = i.age ?? ""
            sign = i.sign ?? ""
            found = i.found ?? ""
            swim = i.swim ?? ""
            unconscious = i.unconscious ?? ""
            rescuedNote = i.note ?? ""
            
        }
        for i in accidentList {
            
            disease = "\(i.accident ?? "") \(i.type ?? "")"
            procedure = "\(i.procedure ?? "") \(i.yourProc ?? "")"
            caseDescribe = i.note ?? ""
            improvement = i.improvement ?? ""
        }
       
    }
    
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        
        let newReport = AddReport()
        
        newReport.date = Date()
        newReport.reportDate = reportDate
        
        newReport.lifeGuardName = lifeGuardName
        newReport.lifeStation = lifeStation
        newReport.place = place
        newReport.alarmed = alarmed
        newReport.lifeEquipment = lifeEquipment
        newReport.extraHelp = extraHelp
        newReport.lifeNote = lifeNote
        
        newReport.rescuedName = rescuedName
        newReport.ageGender = ageGender
        newReport.sign = sign
        newReport.found = found
        newReport.swim = swim
        newReport.unconscious = unconscious
        newReport.rescuedNote = rescuedNote
        
        newReport.disease = disease
        newReport.procedure = procedure
        newReport.caseDescribe = caseDescribe
        newReport.improvement = improvement
        
        saveReport(report: newReport)
        
        //  back to previous page and refresh tableView with segue
        self.performSegue(withIdentifier: "backtoreport", sender: self)
        
       
    }
    
    //MARK: - save and load Report
    
    func saveReport(report: AddReport) {
        do {
            try realm.write{
                realm.add(report)
            }
        } catch {
            print("Error saving item, \(error)")
        }
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            
            
            
            
        }else if indexPath.section == 1{
            let lifeguard = lifeguardList[indexPath.row]
            let LifeFormVC = FromLifeGuardVC(lifeguard)
            self.navigationController?.pushViewController(LifeFormVC, animated: true)
            
        }else if indexPath.section == 2{
            let rescued = rescuedList[indexPath.row]
            let rescuedFormVC = FromRescuedVC(rescued)
            self.navigationController?.pushViewController(rescuedFormVC, animated: true)
            
        }else if indexPath.section == 3{
            let accident = accidentList[indexPath.row]
            let accidentFormVC = FromAccidentVC(accident)
            self.navigationController?.pushViewController(accidentFormVC, animated: true)
            
        }
        
        
        
    }
   
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
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

     
       // note
       let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell

        if indexPath.section == 0 {

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
            
            cell.textLabel?.text = "Our Goal is Zero Drowning.."
            cell.imageView?.image = UIImage(systemName: "leaf")
            cell.textLabel?.textColor = #colorLiteral(red: 0.9792179465, green: 0.4215875864, blue: 0.4211912155, alpha: 1)
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
            
           
            
        }
//        else if indexPath.section == 5{
//
//            // set custom cell as delegate
//            fieldCell.field.delegate = self
//
//            fieldCell.imageView?.image = UIImage(systemName: "exclamationmark.shield")
//            fieldCell.field.placeholder = "any suggestion for improvement"
//            fieldCell.field.textAlignment = .center
//
//            return fieldCell
//
//
//        }
        
        
        
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
            return "Goal"
        }
        
    }

    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//        print("end")
//        textField.resignFirstResponder()
//    }
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        print("return")
//        textField.resignFirstResponder()
//        return true
//    }
//
    
    

    @objc func doneDatePressed() {
        cellText.field.text = formatter.string(from: datePicker.date)
        reportDate = formatter.string(from: datePicker.date)
        cellText.field.resignFirstResponder()

    }

    @objc func todayDatePressed() {
        cellText.field.text = formatter.string(from: Date())
        reportDate = formatter.string(from: datePicker.date)
        cellText.field.resignFirstResponder()

    }

}

