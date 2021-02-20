//
//  CategoryReportTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-04.
//

import UIKit
import RealmSwift

class CategoryReportTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var report: Results<AddReport>?

    override func viewDidLoad() {
        super.viewDidLoad()

        loadItems()
        tableView.rowHeight = 70.0
    }
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return report?.count ?? 1
    }

 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)

        // Configure the cell...
        cell.imageView?.image = UIImage(systemName:  "doc.text")
        cell.textLabel?.text = report?[indexPath.row].lifeGuardName ?? "no"
        cell.detailTextLabel?.text = report?[indexPath.row].reportDate
      

        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ShowReSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowReSegue" {
            let destinationVC = segue.destination as! ShowReportTableViewController
            
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.showReport = report?[indexPath.row]
            }
            
            
        }
            
        }
    
    
    // handle delete 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            
            if let itemForDelete = self.report?[indexPath.row] {
                
                do {
                    try self.realm.write {
                        
                        self.realm.delete(itemForDelete)
                        
                    }
                } catch {
                    print("error delete item \(error)")
                }
                
            }
            tableView.reloadData()
        
        
        
        }
    }
        
    
    //MARK: - Exit Segue
    // segue exit func to refresh tableView with dismiss other page
    @IBAction func unwindToViewControllerA(segue: UIStoryboardSegue) {
        DispatchQueue.global(qos: .userInitiated).async {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
 
    
    // MARK: - Items
    func loadItems() {
//        sort database by last date first to show in table view
        report = realm.objects(AddReport.self).sorted(byKeyPath: "date", ascending: false)
        _ = report?.first
        
        tableView.reloadData()
        
    }
    
}

  


// language 
extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self)
    }
}


