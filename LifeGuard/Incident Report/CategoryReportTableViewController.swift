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
        tableView.rowHeight = 60.0
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
        cell.textLabel?.text = report?[indexPath.row].lifeGuardName
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
//        soert database by last date first to shwo in table view
        report = realm.objects(AddReport.self).sorted(byKeyPath: "date", ascending: false)
        _ = report?.first
        
        tableView.reloadData()
        
    }
    
}

  

