//
//  ShowFirstAidTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-04-25.
//

import UIKit

class ShowFirstAidTableViewController: UITableViewController {
    
    var selectedAid = FirstAidModel()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showAidCell", for: indexPath)
        
        // prepare cell to reuse
        cell.textLabel?.text = nil
        cell.imageView?.image = nil
        cell.textLabel?.textColor = nil
        cell.textLabel?.font = nil
        cell.backgroundColor = nil
        
        // Configure the cell...
        if indexPath.section == 0 {
            cell.textLabel?.text = selectedAid.name
            cell.textLabel?.textAlignment = .left
            cell.imageView?.image = UIImage(systemName: "cross")
            cell.selectionStyle = .none
            cell.backgroundColor = .secondarySystemBackground
            cell.textLabel?.textColor = UIColor(named: "lifeGuardColor")
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 22.0)
            cell.textLabel?.numberOfLines = 0
        }else if indexPath.section == 1{
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 10, width: cell.frame.width - 10, height: cell.frame.height - 10))
            let image = selectedAid.image
            imageView.image = image
            cell.backgroundView = imageView
            cell.selectionStyle = .none
        
            
        }else if indexPath.section == 2 {
            cell.textLabel?.text = selectedAid.describe
            cell.textLabel?.textAlignment = .left
            cell.textLabel?.textColor = UIColor(named: "lifeGuardColor")
//            cell.backgroundColor = UIColor(named: "salmonColor")
            
            
            cell.backgroundColor = .systemBackground
            cell.textLabel?.numberOfLines = 0
            cell.selectionStyle = .none
            
            
        
            
        }else {
            
            cell.textLabel?.text = "Cancel"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
            cell.textLabel?.textColor = UIColor(named: "lifeGuardColor")
            cell.backgroundColor = UIColor(named: "salmonColor")
            
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 3 {
            dismiss(animated: true, completion: nil)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return selectedAid.name
        }else{
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 {
               return 560
           }else {
               return UITableView.automaticDimension
           }
       }
    
    
    
}
