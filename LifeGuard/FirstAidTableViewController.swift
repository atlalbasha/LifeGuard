//
//  FirstAidTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-04-25.
//

import UIKit



class FirstAidTableViewController: UITableViewController {
    
    
    var firstAid = FirstAidBrain()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return firstAid.countAid.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         if section == 0 {
            return firstAid.LABC.count
        }else if section == 1 {
            return firstAid.firstAid.count
        }else if section == 2 {
            return firstAid.phone.count
        }else{
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstAidCell", for: indexPath)

        
        // Configure the cell...
        
        if indexPath.section == 0{
            cell.imageView?.image = firstAid.image
            cell.textLabel?.text = firstAid.LABC[indexPath.row].name
            cell.detailTextLabel?.text = nil
        }else if indexPath.section == 1{
            cell.imageView?.image = firstAid.image
            cell.textLabel?.text = firstAid.firstAid[indexPath.row].name
            cell.detailTextLabel?.text = nil
        }else if indexPath.section == 2{
            cell.imageView?.image = firstAid.phone[indexPath.row].image
            cell.textLabel?.text = firstAid.phone[indexPath.row].name
            cell.detailTextLabel?.text = firstAid.phone[indexPath.row].describe
            cell.accessoryType = .disclosureIndicator
            
            
        }
        return cell
    }

       
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFirstAidSegue", sender: self)
       
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFirstAidSegue"{
           
            let VC = segue.destination as! ShowFirstAidTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                if indexPath.section == 0 {
                
                    VC.selectedAid = firstAid.LABC[indexPath.row]
                }else if indexPath.section == 1 {
                    
                    VC.selectedAid = firstAid.firstAid[indexPath.row]
                    
                }else if indexPath.section == 2{
                    
                  
                    let indexPhone = firstAid.phone[indexPath.row].describe
                    
                    // alert controller
                    let alert = UIAlertController(title: "Make a Call", message: indexPhone, preferredStyle: .alert)
                    
                    // cancel button
                    let cancelPressed = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in
                        self.dismiss(animated: true, completion: nil)
                        
                    }
                    
                    // add button
                    let addPressed = UIAlertAction(title: "Call", style: .default) {
                        (cancelPressed) in
                        
                        self.callNumber(phoneNumber: indexPhone!)
                    }
                    
                    alert.view.tintColor = UIColor(named: "salmonColor")
                    alert.addAction(cancelPressed)
                    alert.addAction(addPressed)
                
                    present(alert, animated: true, completion: nil)
                    
                    
                }else{
                    
                    
                 
                    tableView.deselectRow(at: indexPath, animated: true)
                }
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "LABC"
        }else if section == 1{
            return "First Aid"
        }else if section == 2{
            return "Phone Number"
        }else if section == 3{
            return "Coming more"
        }else {
            return nil
        }
    }
    
 
    // call 
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

   

}
