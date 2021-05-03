//
//  NotesTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-29.
//

import UIKit
import RealmSwift


class NotesTableViewController: UITableViewController {
    
    let dateCreated = Date()
    let formatter = DateFormatter()
    let calendar = Calendar.current
    
    
    let realm = try! Realm()
    var addNotes: Results<AddNote>?
    var logbooks: Results<CategoryLogbook>?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNote()
        
        //row hight in table View
        tableView.rowHeight = 70.0
        
    }
    
    // MARK: - Table view data source
    
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return addNotes?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
       
        // Configure the cell...
        let noteString = addNotes?[indexPath.row].title ?? "no"
        let resultPrefix = noteString.prefix(20)
        
        
        
        self.formatter.dateFormat = "dd MMM HH:mm"
        let noteDate = addNotes?[indexPath.row].date
        
        let stringDate = self.formatter.string(from: noteDate!)
        
        cell.textLabel?.text = "\(resultPrefix)..."
        cell.detailTextLabel?.text = stringDate
        
       
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        performSegue(withIdentifier: "itemSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        // get all text in the note to show it in alert
        let indexTitle = self.addNotes?[indexPath.row]
        let noteTitle = indexTitle!.title
        
        let alert = UIAlertController(title: "Note:", message: noteTitle, preferredStyle: .alert)
        
        // cancel button in textField alert
        let cancelPressed = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let deletePressed = UIAlertAction(title: "Delete", style: .default) { (deletePressed) in
            print("delete")
            if let itemForDelete = self.addNotes?[indexPath.row] {
                
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
        
        alert.view.tintColor = UIColor(named: "salmonColor")
        alert.addAction(cancelPressed)
        alert.addAction(deletePressed)
        
        present(alert, animated: true, completion: nil)
        
        
        
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        editButtonItem.image = UIImage(systemName: "trash")
        
        if (editingStyle == .delete) {
           
            if let itemForDelete = self.addNotes?[indexPath.row] {
                
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
   
    
    
    
    @IBAction func addNotePressed(_ sender: Any) {
        
        
        // textField i alert
        var textField = UITextField()
        
        
        // text alert controller
        let alert = UIAlertController(title: "Add Note", message: "", preferredStyle: .alert)
        
        // cancel button in textField alert
        let cancelPressed = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in
            self.dismiss(animated: true, completion: nil)
            
        }
        
        
        
        // add button in textField alert
        let addPressed = UIAlertAction(title: "Add", style: .default) {
            (cancelPressed) in
            
            
            
            if(textField.text != "")
            {
                // add new note
                let newNote = AddNote()
                newNote.date = Date()
                newNote.title = textField.text!
                
                self.saveNote(note: newNote)
            }
            
        }
        
        alert.view.tintColor = UIColor(named: "salmonColor")
        alert.addAction(cancelPressed)
        alert.addAction(addPressed)
        
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Type Note..."
            
        }
        
        
        present(alert, animated: true, completion: nil)
        
    }
    
    // MARK: - Items
    
    func loadNote() {
        //        sort database by last date first to show in table view
        addNotes = realm.objects(AddNote.self).sorted(byKeyPath: "date", ascending: false)
        _ = addNotes?.first
        
        tableView.reloadData()
    }
    
    
    //    save new logbook in database "commit"
    func saveNote(note: AddNote) {
        
        do {
            try realm.write{
                // logbook.today.append(note)
                
                realm.add(note)
            }
        } catch {
            print("Error saving item, \(error)")
        }
        
        tableView.reloadData()
    }
    
    
    
    
}


