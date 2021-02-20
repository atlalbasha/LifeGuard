//
//  ItemsTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-23.
//

import UIKit
import RealmSwift
import SwipeCellKit

class ItemsTableViewController: UITableViewController {
    
    let realm = try! Realm()
    var logbookItem: Results<ItemLogbook>?
    
    var inItemAdd = AddItemViewController()
    
    
    var selectedLogbook: CategoryLogbook? {
        didSet{
            loadItems()
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change nav title color
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2736076713, green: 0.249892056, blue: 0.5559395552, alpha: 1)]
        
        
        loadItems()
        
        tableView.rowHeight = 70.0
        
        
        
        
    }
    
    
    // MARK: - Table view data source
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return logbookItem?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    
    
   
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath)
        
        // Configure the cell...
        
        
        cell.textLabel?.text = logbookItem?[indexPath.row].title ?? "No Item Added"
        cell.imageView?.image = UIImage(systemName: "wallet.pass")
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItemSegue" {
            let destinationVC = segue.destination as! ReportTableViewController
            destinationVC.selectedItemLogbook = selectedLogbook
            
        } else if segue.identifier == "showSegue" {
            let destinationVC = segue.destination as! ShowItemTableViewController
            if let indexPath = tableView.indexPathForSelectedRow{
                destinationVC.showItem = logbookItem?[indexPath.row]
            }
            
        }
        
    }
    
    // delete handle 
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        editButtonItem.image = UIImage(systemName: "trash")
        
        if (editingStyle == .delete) {
           
            // delete item in logbooks database realm
            if let itemForDelete = self.logbookItem?[indexPath.row] {
                
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
    
    
    
    // MARK: - Items
    func loadItems() {
        //        soert database by last date first to shwo in table view
        logbookItem = selectedLogbook?.items.sorted(byKeyPath: "date", ascending: false)
        _ = logbookItem?.first
        
        
        tableView.reloadData()
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
    //-------
    
    
    
    func saveItem(item: ItemLogbook) {
        if let currentCategory = self.selectedLogbook {
            do{
                try self.realm.write{
                    currentCategory.items.append(item)
                }
            }catch{
                print("Error saving new Item \(error)")
            }
        }
        
        tableView.reloadData()
        
    }
   
}







////MARK: - Swipe delegate method
//
//extension ItemsTableViewController: SwipeTableViewCellDelegate {
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
//        guard orientation == .right else { return nil }
//
//        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
//            // handle action by updating model with deletion
//
//            if let itemForDelete = self.logbookItem?[indexPath.row] {
//                do {
//                    try self.realm.write {
//                        self.realm.delete(itemForDelete)
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
