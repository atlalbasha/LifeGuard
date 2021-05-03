//
//  ShowReportTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-19.
//

import UIKit
import RealmSwift
import WebKit
import PDFKit

class ShowReportTableViewController: UITableViewController, WKUIDelegate {
    
    var webView: WKWebView?
    var htmlString: String?
    
    let realm = try! Realm()
    var report: Results<AddReport>?
    
    var showReport: AddReport? {
        didSet{
            htmlString = """
                <!DOCTYPE html>
                <html>
                <head>

                </head>
                <body  topmargin="50" leftmargin="50" rightmargin="50">

                <h2 style="text-align:left;float:left;">Accident Report \(showReport?.lifeStation ?? "")</h2>
                <h4 style="text-align:right;float:right;">Date:\(showReport?.reportDate ?? "")</h4>
                <hr style="clear:both;"/>

                <div>

                <h3>Lifeguard info</h3>

                <p style="text-align:left;float:left;">Lifeguard Name: \(showReport?.lifeGuardName ?? "")</p>
                <p style="text-align:right;float:right;">Life Station: \(showReport?.lifeStation ?? "")</p>
                <br style="clear:both;"/>

                <p style="text-align:left;float:left;">Place: \(showReport?.place ?? "")</p>
                <p style="text-align:right;float:right;">How Alarmed: \(showReport?.alarmed ?? "")</p>
                <br style="clear:both;"/>

                <p style="text-align:left;float:left;">Life Equipment: \(showReport?.lifeEquipment ?? "")</p>
                <p style="text-align:right;float:right;">Extra Help: \(showReport?.extraHelp ?? "")</p>
                <br style="clear:both;"/>

                <p>Note: \(showReport?.lifeNote ?? "")</p>

                <hr>

                <h3>Rescued info</h3>

                <p style="text-align:left;float:left;">Rescued Name: \(showReport?.rescuedName ?? "")</p>
                <p style="text-align:right;float:right;">Age and Gender: \(showReport?.ageGender ?? "")</p>
                <br style="clear:both;"/>

                <p style="text-align:left;float:left;">Call for Help: \(showReport?.sign ?? "")</p>
                <p style="text-align:right;float:right;">Found: \(showReport?.found ?? "")</p>
                <br style="clear:both;"/>

                <p style="text-align:left;float:left;">Can Swim: \(showReport?.swim ?? "")</p>
                <p style="text-align:right;float:right;">Unconscious: \(showReport?.unconscious ?? "")</p>
                <br style="clear:both;"/>

                <p>Note: \(showReport?.rescuedNote ?? "")</p>

                <hr>

                <h3>Accident and Disease</h3>
                <p>Accident: \(showReport?.disease ?? "")</p>
                <p>Procedure: \(showReport?.procedure ?? "")</p>
                <p>Case Describe: \(showReport?.caseDescribe ?? "")</p>
                <p>Improvement: \(showReport?.improvement ?? "")</p>

                </div>

                </body>
                </html>

                """
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView = WKWebView.init(frame:self.view.frame)
        self.webView?.loadHTMLString(htmlString!, baseURL: nil)

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
    
    @IBAction func deletePressed(_ sender: Any) {
        
        
        let alert = UIAlertController(title: "Delete:", message: "Delete Accident Report", preferredStyle: .alert)
        
        // cancel button in textField alert
        let cancelPressed = UIAlertAction(title: "Cancel", style: .default) { (cancelPressed) in
            self.dismiss(animated: true, completion: nil)
        }
        
        let deletePressed = UIAlertAction(title: "Delete", style: .default) { (deletePressed) in
            
                do {
                    try self.realm.write {
                        
                        self.realm.delete(self.showReport!)
                        
                    }
                } catch {
                    print("error delete item \(error)")
                }
            //  back to previous page and refresh tableView with segue
            self.performSegue(withIdentifier: "backtoreport", sender: self)
            
                
            }
            
        
        alert.view.tintColor = UIColor(named: "salmonColor")
        alert.addAction(cancelPressed)
        alert.addAction(deletePressed)
        
        present(alert, animated: true, completion: nil)
        
        
        
        
    }
    
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }else if section == 1{
            return 7
        }else if section == 2{
            return 7
        }else if section == 3{
            return 2
        }else if section == 4{
            return 1
        }else{
            return 1
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showReportInfoCell", for: indexPath)
        
        // prepare cell to reuse
        cell.textLabel?.text = nil
        cell.detailTextLabel?.text = nil

        if indexPath.section == 0 {
            
            
            
//            cell.imageView?.image = UIImage(systemName: "calendar.badge.clock")
            cell.textLabel?.text = showReport?.reportDate
            cell.detailTextLabel?.isHidden = true
            
        }else if indexPath.section == 1 {
            
          
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Lifeguard Name"
                cell.detailTextLabel?.text = showReport?.lifeGuardName
                
            }else if indexPath.row == 1 {
                
                cell.textLabel?.text = "LifeSave Station"
                cell.detailTextLabel?.text = showReport?.lifeStation
                
            }else if indexPath.row == 2 {
                
                cell.textLabel?.text = "Place"
                cell.detailTextLabel?.text = showReport?.place
                
            }else if indexPath.row == 3 {
                
                cell.textLabel?.text = "Alarmed"
                cell.detailTextLabel?.text = showReport?.alarmed
                
            }else if indexPath.row == 4 {
                
                cell.textLabel?.text = "Equipment"
                cell.detailTextLabel?.text = showReport?.lifeEquipment
                
            }else if indexPath.row == 5 {
                
                cell.textLabel?.text = "Other Help"
                cell.detailTextLabel?.text = showReport?.extraHelp
                
            }else {
                cell.textLabel?.text = "Note \(showReport?.lifeNote ?? "")"
                cell.detailTextLabel?.isHidden = true
                
            }
            
        }else if indexPath.section == 2 {
            
            if indexPath.row == 0 {
                cell.textLabel?.text = "Rescued Name"
                cell.detailTextLabel?.text = showReport?.rescuedName
                
            }else if indexPath.row == 1 {
                cell.textLabel?.text = "Age, Gender"
                cell.detailTextLabel?.text = showReport?.ageGender
                
            }else if indexPath.row == 2 {
                cell.textLabel?.text = "Call for Help"
                cell.detailTextLabel?.text = showReport?.sign
                
            }else if indexPath.row == 3 {
                cell.textLabel?.text = "Found"
                cell.detailTextLabel?.text = showReport?.found
                
            }else if indexPath.row == 4 {
                cell.textLabel?.text = "Can Swim"
                cell.detailTextLabel?.text = showReport?.swim
                
            }else if indexPath.row == 5 {
                cell.textLabel?.text = "Unconscious"
                cell.detailTextLabel?.text = showReport?.unconscious
                
            }else {
                cell.textLabel?.text = "Note \(showReport?.rescuedNote ??  "")"
                cell.detailTextLabel?.isHidden = true
                
            }
            
        }else if indexPath.section == 3 {
            if indexPath.row == 0 {
                cell.textLabel?.text = "Accident, Disease"
                cell.detailTextLabel?.text = showReport?.disease
                
            }else if indexPath.row == 1 {
                cell.textLabel?.text = "Procedure"
                cell.detailTextLabel?.text = showReport?.procedure
                
            }
        }else if indexPath.section == 4 {
            cell.textLabel!.numberOfLines = 0
            cell.textLabel!.lineBreakMode = .byWordWrapping
           cell.textLabel?.text = showReport?.caseDescribe
            cell.detailTextLabel?.isHidden = true
             
            
        }else {
            cell.textLabel?.text = showReport?.improvement
            cell.detailTextLabel?.isHidden = true
        }
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        
        return cell
    }
    
 
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Date"
        }else if section == 1 {
            return "LifeGuard info"
        }else if section == 2 {
            return "Rescued info"
        }else if section == 3 {
            return "Accident, Procedure"
        }else if section == 4 {
            return "Case Describe"
        }else {
            return "Improvement"
        }
    }

   


}
