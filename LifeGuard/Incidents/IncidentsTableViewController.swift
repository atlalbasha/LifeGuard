//
//  IncidentsTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-29.
//

import UIKit
import RealmSwift


class IncidentsTableViewController: UITableViewController {
    
    let dateCreated = Date()
    let formatter = DateFormatter()
    let calendar = Calendar.current
    
    
    let realm = try! Realm()
    var incidents: Results<AddIncident>?
    
    
    
//    var addedIncident: AddIncident? {
//        didSet{
//            loadItems()
//
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableView.rowHeight = 70.0
        
        loadItems()
    }

    // MARK: - Table view data source

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return incidents?.count ?? 1
    }

    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "incell", for: indexPath) as! // SwipeTableViewCell
//
//        // Configure the cell...
//
//        self.formatter.dateStyle = .medium
//        self.formatter.timeStyle = .short
//        let result = self.formatter.string(from: self.dateCreated)
//
//         Configure the cell...
//        let nameTitle = incidents?[indexPath.row].name
//
//        cell.imageView?.image = UIImage(systemName: "wallet.pass")
//        cell.textLabel?.text = nameTitle ?? "No Item Added"  // .title
//        cell.detailTextLabel?.text = result
//
//        cell.delegate = self
//
//
//        return cell
//    }
//

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        incidents = realm.objects(AddIncident.self).sorted(byKeyPath: "date", ascending: false)
        _ = incidents?.first
        
        tableView.reloadData()
        
    }
    
}



//MARK: - Swipe delegate method

//extension IncidentsTableViewController: SwipeTableViewCellDelegate {
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//
//            // delet item in logbooks database realm
//            if let itemForDelete = self.incidents?[indexPath.row] {
//
//                do {
//                    try self.realm.write {
//
//                        self.realm.delete(itemForDelete)
//
//                    }
//                } catch {
//                    print("error delete item \(error)")
//                }
//
//            }
//
//        }
//
//        // customize the action appearance
//        deleteAction.image = UIImage(named: "trash-Icon")
//
//        return [deleteAction]
//    }
//    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
//        var options = SwipeOptions()
//        options.expansionStyle = .destructive
//        return options
//    }
//}
//
//
//
//


