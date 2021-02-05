//
//  ChoiceTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-04.
//

import UIKit

struct Choiche {
    let title: String
    var done: Bool = false
}

class ChoiceTableViewController: UITableViewController {
    
    
    var selectedItems: [String] = []
    var choice: [Choiche] = []
    var addChoice: [Choiche] = []
    var getChoice: [String] = []
 
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for itemTitle in selectedItems{
            choice = [
                Choiche(title: itemTitle)
            ]
            addChoice.append(contentsOf: choice)
//            print(choice)
            
        }
        
        print(addChoice)
        
        print(selectedItems)
        
    }

    // MARK: - Table view data source

  

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addChoice.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "choiceCell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = addChoice[indexPath.row].title
        
        if addChoice[indexPath.row].done == true {
            cell.accessoryType = .checkmark
            getChoice.append(addChoice[indexPath.row].title)
        }else{
            cell.accessoryType = .none
        }
        
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        addChoice[indexPath.row].done = !addChoice[indexPath.row].done
        
//        performSegue(withIdentifier: "getChoice", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        tableView.reloadData()
        print(selectedItems[indexPath.row])
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "getChoice" {
            let destinationVC = segue.destination as! AddIncidentReportTableViewController
            if let indexPath = tableView.indexPathForSelectedRow {
                
              
//                        let category = addChoice[indexPath.row]
                        
                destinationVC.selectedChoice = getChoice
                
                
                
         
            }
            
            
        }
    }

}
