//
//  AddIncidentReportTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-04.
//

import UIKit


struct Report {
    let title: String
    let items: [String]
    
    
}


class AddIncidentReportTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    var selectedChoice: [String] = []
    
    
    let basicInfo = ["LifeGuard Name:", "LifeSaving Station", "Date of The Instanc","Place of the Instance"]
    
    let infoAboutRescued = ["Name", "Age", "Gender","Other info"]
    
    let rescuedCase = ["Emergency Signs, Shouts", "Found Below The Surface"]
    
    let descibe = ["Descibe The Procedure in Your Words","Do You Have Any Suggestions of Improvment?"]
    
    
    
    
    
    let data: [Report] = [
        
        Report(title: "Distance from The Beach", items: ["Less Than 50 meter","50-100 meter", "100-200 meter", "More Than 200 meter"])
        ,Report(title: "Who Alarmed", items: ["Public","LifeGuard"])
        ,Report(title: "Lifesaving Equipment", items: ["Nothing","Livboj","Torpedo","Rescue Board","Drones"])
        ,Report(title: "External Help", items: ["Abmbulance","Rescue Service","Sea Rescue","The Coast Guard","Helicopter", "Polis", "Public"])
        
        ,Report(title: "Type of Disease, Accident", items: ["Heart Attack", "Neck-Back Injury", "Heat Stroke","Wounds","Worm Body Part","Snake,Insect Animal Bite","Cramp ","Drowning","Jellyfish", "Fire","Shock", "Head Injury","Burns","External Bleeding","Lose a Tooth", "Asthma","Missing Person","Threat, Violence","Fainting","Circulatory Failure", "Cooling","Fractures, Sprain", "Nosebleeds",  "Allergic Reaction",  "Diabetes","Kris, Chock,",    "Posoning, Burns", " Prevention"])
        
        
        ,Report(title: "Procedure", items: ["Rescue Below The Surface","Rescue at The Surface","Towing","Transport to Ambulance","Trasport to Hospital","Breath i Water","Breath on Beach","Fire Extinguisher","Stable Side Position","Blanket, Nursing","Defibrillation","Cooling","Alarmed SOS", "HLR", "Skull Passage Chain","Manual Fixation","High Mode","Plan Mode", "Trasport Taxi"])
        
        // Basic info
        //        Report(title: "LifeGuard Name:", items: ["Atlal Basha"])
        //        ,Report(title: "LifeSaving Station", items: ["tex: Askim"])
        //        ,Report(title: "Date of The Instanc", items: ["2020/10/10 - 20:30 am"])
        //        ,Report(title: "Place of the Instance", items: ["Beach, Water"])
        //
        //        // info About The Rescued
        //        ,Report(title: "Name", items: ["name"])
        //        ,Report(title: "Gender", items: ["Male", "Female"])
        //        ,Report(title: "Age", items: ["19"])
        //        ,Report(title: "Other", items: ["type more info"])
        //        //
        // case
        
        //        Report(title: "Emergency Signs, Shouts", items: ["yes no"])
        //        ,Report(title: "Found Below The Surface", items: ["yes no"])
        //
    ]
    
    
    //MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register custom cell
        tableView.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        
        
        
        
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return basicInfo.count
        }else if section == 1{
            return infoAboutRescued.count
        }else if  section == 2{
            return rescuedCase.count
        }else if  section == 3{
            return data.count
        }else {
            return descibe.count
        }
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addInciReportCell", for: indexPath)
        //         Configure the cell...
        
        // lifeGuard
        if indexPath.section == 0 {
            
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            
            // set custom cell as delegate
            fieldCell.field.delegate = self
            fieldCell.field.placeholder = "here"
            fieldCell.tag = indexPath.row
            
            return fieldCell
            
            // Rescued
        }else if indexPath.section == 1{
            
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            
            // set custom cell as delegate
            fieldCell.field.delegate = self
            fieldCell.field.placeholder = "here"
            fieldCell.tag = indexPath.row
            
            return fieldCell
            
        }else if indexPath.section == 2{
            let mySwitch = UISwitch()
            cell.textLabel?.text = rescuedCase[indexPath.row]
          
            cell.detailTextLabel?.text = "No/Yes"
            cell.accessoryView = mySwitch
            mySwitch.isOn = false
            mySwitch.tag = indexPath.row
            
            
        }else if indexPath.section == 3{
            
            cell.textLabel?.text = data[indexPath.row].title
            
            let category = data[indexPath.row]
            
            
//            cell.detailTextLabel?.text = category.items[indexPath.row]
            
            if selectedChoice.count != 0 {
                for i in selectedChoice{
                    for j in category.items{
                        if i == j{
                            cell.detailTextLabel?.text = "\(j)"
                        }
                        
                    }
                    
                }

            }
            
        }else{
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            
            // set custom cell as delegate
            fieldCell.field.delegate = self
            fieldCell.field.placeholder = "here"
            
            return fieldCell
        }
        
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let sectionNumber = indexPath.section
        print(sectionNumber)
        print(indexPath.row)
        
      if sectionNumber == 3{
            print("4")
            performSegue(withIdentifier: "choiceSegue", sender: self)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "choiceSegue" {
            let destinationVC = segue.destination as! ChoiceTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
              
                        let category = data[indexPath.row]
                        
                        destinationVC.selectedItems = category.items
                
                
                
         
            }
            
            
        }
    }
    // add title header to section taible view
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Basic info"
        }else if  section == 1{
            return "info About The Rescued"
        }else if  section == 2{
            return "Case"
        }else if  section == 3{
            return "Accident And Procedure"
        }else{
            return "Descibe"
        }
        
        
    }
    
    
    //MARK: - Exit Segue
    // segue exit func to refresh tableView with dismiss other page
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.selectedChoice)
            }
        }
    }
}


