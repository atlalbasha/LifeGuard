//
//  CategoryLogbookTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-22.
//

import UIKit
import RealmSwift
import SwipeCellKit
import WebKit
import PDFKit



class CategoryLogbookTableViewController: UITableViewController, WKUIDelegate {
    
    var webView: WKWebView?
    var htmlString: String?
    
    let realm = try! Realm()
    var logbooks: Results<CategoryLogbook>?
    
    
    // date and formatter
    let dateCreated = Date()
    let formatter = DateFormatter()
    let calendar = Calendar.current
    
    
    
    // MARK: - pull and refresh
    @objc func refresh(sender:AnyObject)
    {
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    
    //    MARK: - View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        // change nav title color
        //        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2736076713, green: 0.249892056, blue: 0.5559395552, alpha: 1)]
        
        loadLogbook()
        
        // pull and refresh table view to show last count of time report
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        
        //row hight in table View
        tableView.rowHeight = 70.0
        
        
        
    }
    @IBAction func actionPressed(_ sender: UIBarButtonItem) {
        
        let docsDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let pdfFile = docsDir.appendingPathComponent("LifeGuard.pdf")
        
        let pdfDocument = webView!.exportAsPDF()!
        
        pdfDocument.write(to: pdfFile)
        
        
        let activityVC = UIActivityViewController(activityItems: [pdfFile], applicationActivities: nil)
        
        present(activityVC, animated: true, completion: nil)
        
        print(pdfFile.path)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
        var htmlTableString: String = ""
        
       
        
        for i in logbooks! {
            
            htmlTableString = """
           
            
            <td>\(i.items[0].title)</td>
            <td>\(i.items[0].air_temp)</td>
            <td>\(i.items[0].water_temp)</td>
            <td>\(i.items[0].wind_speed)</td>
            <td>\(i.items[0].wind_direction)</td>
            <td>\(i.items[0].people_on_beach)</td>
            <td>\(i.items[0].people_in_water)</td>
            <td>\(i.items[0].flag)</td>
            <td>\(i.items[0].streams)</td>
            <td>\(i.items[0].note)</td>
            

            
            
"""
           
        }
        
        htmlString = """
            <!DOCTYPE html>
            <html>
            <head>
            <style>
            table, th, td {
            border: 1px solid black;
            border-collapse: collapse;
            }
            </style>
            </head>
            <body>

            <h2 style="text-align:left;float:left;">Logbook Report Place:</h2>
            <style="clear:both;"/>

            <table style="width:100%">
            <tr>
            <th>Time</th>
            <th>Air Temp</th>
            <th>Water Temp</th>
            <th>Wind Speed</th>
            <th>Wind direction</th>
            <th>People in Beach</th>
            <th>People in Water</th>
            <th>Flag</th>
            <th>Streams</th>
            <th>Note</th>
            
            </tr>
            \(htmlTableString)
            </tr>

            </table>

            </body>
            </html>

            
            


            """
        
        
        // webview HTML to pdf
        self.webView = WKWebView.init(frame:self.view.frame)
        self.webView?.loadHTMLString(htmlString ?? "", baseURL: nil)
        
        
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
    
    
    //    MARK: - popup alert text
    // add button in tab new daily logbook
    @IBAction func addPressed(_ sender: UIBarButtonItem) {
        
        //     check if already added day logbook
        let startOfDay = calendar.date(bySettingHour: 00, minute: 00, second: 00, of: dateCreated)
        let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: dateCreated)
        
         for i in logbooks! {
         
         if i.date! > startOfDay! && i.date! < endOfDay!  {
         
         
         let alreadyAdded = UIAlertController(title: "Today's Report Already Created!", message: "Add a New One Tomorrow", preferredStyle: .alert)
         
         let cancelPressed = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in
         self.dismiss(animated: true, completion: nil)
         }
         alreadyAdded.addAction(cancelPressed)
         present(alreadyAdded, animated: true, completion: nil)
         }
         
         }
         
        
        // textField i alert
        var textField = UITextField()
        
        // text alert controller
        let alert = UIAlertController(title: "Add a Daily Logbook Report", message: "Once at the beginning of each day", preferredStyle: .alert)
        
        // cancel button in textField alert
        let cancelPressed = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in
            self.dismiss(animated: true, completion: nil)
        }
        cancelPressed.setValue(UIColor.systemPink, forKey: "titleTextColor")
        
        // add buttom in textField alert
        let actionPressed = UIAlertAction(title: "Add", style: .default) {
            (cancelPressed) in
            
            
            
            if(textField.text != "")
            {
                // date formatter for add it to title
                self.formatter.dateStyle = .medium //"E, d MMM yyyy"
                let result = self.formatter.string(from: self.dateCreated)
                
                // add new logbook
                let newLogbook = CategoryLogbook()
                newLogbook.date = Date()
                newLogbook.title = "\(textField.text!.capitalized) - \(result)"
                
                self.saveLogbook(logbook: newLogbook)
            }
            
        }
        
        actionPressed.setValue(UIColor(named: "prupleColor"), forKey: "titleTextColor")
        
        
        
        alert.addAction(cancelPressed)
        alert.addAction(actionPressed)
        
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Type Beach Name..."
            
        }
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
    // MARK: - Items
    
    func loadLogbook() {
        //        soert database by last date first to shwo in table view
        logbooks = realm.objects(CategoryLogbook.self).sorted(byKeyPath: "date", ascending: false)
        _ = logbooks?.first
        
        tableView.reloadData()
    }
    
    
    //    save new logbook in database "commit"
    func saveLogbook(logbook: CategoryLogbook) {
        do {
            try realm.write{
                realm.add(logbook)
            }
        } catch {
            print("Error saving item, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return logbooks?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "logbookCell", for: indexPath) as! SwipeTableViewCell
        
        // get index count of each logbook items
        let indexCount = self.logbooks?[indexPath.row]
        var count = 0
        for _ in indexCount!.items { count += 1 }
        
        // Configure the cell...
        
        cell.textLabel?.text = logbooks?[indexPath.row].title ?? "No Logbook Added"  // .title
        cell.detailTextLabel?.text = String(count)
        
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "itemSegue", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemSegue" {
            let destinationVC = segue.destination as! ItemsTableViewController
            
            //            send celected logbook
            if let indexPath = tableView.indexPathForSelectedRow {
                destinationVC.selectedLogbook = logbooks?[indexPath.row]
                
            }
        }
    }
}





//MARK: - Swipe delegate method

extension CategoryLogbookTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            // delet item in logbooks database realm
            if let itemForDelete = self.logbooks?[indexPath.row] {
                
                do {
                    try self.realm.write {
                        // must delete item in logbook first then delete logbook day
                        self.realm.delete(itemForDelete.items)
                        
                        self.realm.delete(itemForDelete)
                        
                    }
                } catch {
                    print("error delete item \(error)")
                }
                
            }
            
        }
        
        // customize the action appearance
        deleteAction.image = UIImage(named: "trash-Icon")
        
        return [deleteAction]
    }
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructive
        return options
    }
}



//MARK: - Close iOS Keyboard by touching anywhere

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


