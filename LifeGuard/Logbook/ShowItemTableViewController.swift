//
//  ShowItemTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-18.
//

import UIKit
import RealmSwift
import WebKit
import PDFKit

class ShowItemTableViewController: UITableViewController, WKUIDelegate{
    
    var webView: WKWebView?
    var htmlString: String?
    
    let realm = try! Realm()
    
    
    
    var showItem: ItemLogbook? {
        didSet{
           
            
            htmlString = """
<!DOCTYPE html>
<html>
<head>

</head>
<body  topmargin="100" leftmargin="100" rightmargin="100">

<h2 style="text-align:left;float:left;">Logbook Report</h2>
<h4 style="text-align:right;float:right;">Date: \(showItem?.title ?? "")</h4>
<hr style="clear:both;"/>

<div>

<p>Air Tempratur: \(showItem?.air_temp ?? "") </p>
<p>Water Tempratur: \(showItem?.water_temp ?? "")</p>

<hr>

<p>Wind Speed: \(showItem?.wind_speed ?? "")</p>
<p>Wind direction: \(showItem?.wind_direction ?? "")</p>

<hr>

<p>People on Beach: \(showItem?.people_on_beach ?? "")</p>
<p>People in Water: \(showItem?.people_in_water ?? "")</p>

<hr>

<p>Falg: \(showItem?.flag ?? "")</p>
<p>Streams: \(showItem?.streams ?? "")</p>

<hr>

<p>Note: \(showItem?.note ?? "")</p>

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
    
    
   
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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
            return 2
        }else if section == 2{
            return 2
        }else if section == 3{
            return 2
        }else if section == 4{
            return 2
        }else{
            return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "showCell", for: indexPath)
        if indexPath.section == 0 {
            cell.imageView?.image = UIImage(systemName: "calendar.badge.clock")
            cell.textLabel?.text = showItem?.title
            cell.detailTextLabel?.isHidden = true
            
        }else if indexPath.section == 1 {
            
            if indexPath.row == 0{
                cell.imageView?.image = UIImage(systemName: "thermometer.sun")
                cell.textLabel?.text = "Air Temp"
                cell.detailTextLabel?.text = "\(showItem?.air_temp ?? "")°C"
                
            }else{
                cell.imageView?.image = UIImage(systemName: "thermometer.snowflake")
                cell.textLabel?.text = "Water Temp"
                cell.detailTextLabel?.text = "\(showItem?.water_temp ?? "")°C"
            }
            
            
        }else if indexPath.section == 2 {
            if indexPath.row == 0{
                
                cell.imageView?.image = UIImage(systemName: "wind")
                cell.textLabel?.text = "Wind Speed"
                cell.detailTextLabel?.text = "\(showItem?.wind_speed ?? "")m/s"
            }else{
                
                cell.imageView?.image = UIImage(systemName: "safari")
                cell.textLabel?.text = "Direction"
                cell.detailTextLabel?.text = showItem?.wind_direction
            }
            
            
        }else if indexPath.section == 3{
            if indexPath.row == 0{
                
                cell.imageView?.image = UIImage(systemName: "person.2")
                cell.textLabel?.text = "People on Beach"
                cell.detailTextLabel?.text = showItem?.people_on_beach
            }else{
                
                cell.imageView?.image = UIImage(systemName: "person.2")
                cell.textLabel?.text = "People in Water"
                cell.detailTextLabel?.text = showItem?.people_in_water
            }
            
            
        }else if indexPath.section == 4 {
            if indexPath.row == 0{
                
                cell.imageView?.image = UIImage(systemName: "flag")
                cell.textLabel?.text = "Flag"
                cell.detailTextLabel?.text = showItem?.flag
            }else{
                
                cell.imageView?.image = UIImage(systemName: "tornado")
                cell.textLabel?.text = "Streams"
                cell.detailTextLabel?.text = showItem?.streams
            }
            
            
        }else{
            cell.imageView?.image = UIImage(systemName: "note.text")
            cell.textLabel?.text = "Note"
            cell.detailTextLabel?.text = showItem?.note
        }
        
        
        return cell
    }
    
    
    // add title header to section taible view
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "Date"
        }else if section == 1 {
            return "Tempratur"
        }else if  section == 2{
            return "Wind"
        }else if  section == 3{
            return "People"
        }else if  section == 4{
            return "Flag / Streams"
        }else{
            return "Note"
        }
    }
    
    
    
    
    
}


extension WKWebView {

    // Exports a PDF document with this web view current contents.
    // Only call this function when the web view has finished loading.
    func exportAsPDF() -> PDFDocument? {
        guard self.isLoading == false else {
            print("WKWebView still loading!")
            return nil
        }
        let pdfData = createPDFData()
        return PDFDocument(data: pdfData)
    }

    private func createPDFData() -> Data {
        let oldBounds = self.bounds

        

        var printableRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8)
        printableRect.origin = .zero

        let printRenderer = UIPrintPageRenderer()
        printRenderer.addPrintFormatter(self.viewPrintFormatter(), startingAtPageAt: 0)
        printRenderer.setValue(NSValue(cgRect: printableRect), forKey: "paperRect")
        printRenderer.setValue(NSValue(cgRect: printableRect), forKey: "printableRect")

        self.bounds = oldBounds
        return printRenderer.generatePDFData()
    }
}


extension UIPrintPageRenderer {

    func generatePDFData() -> Data {
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, self.paperRect, nil)
        
     
        
        
        self.prepare(forDrawingPages: NSMakeRange(0, self.numberOfPages))
        let printRect = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
       

        for pdfPage in 0..<self.numberOfPages {
            UIGraphicsBeginPDFPage()
            self.drawPage(at: pdfPage, in: printRect)
        }

        UIGraphicsEndPDFContext()
       
        return pdfData as Data
    }
}
