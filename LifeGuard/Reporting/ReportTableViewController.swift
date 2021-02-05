//
//  ReportTableViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-02-01.
//

import UIKit
import CoreLocation
import RealmSwift



class ReportTableViewController: UITableViewController, UITextFieldDelegate {
    
    
    
    // tableview section row title
    let temperature = ["Air Temp", "Water Temp"]
    let wind = ["Wind Speed", "Direction"]
    let people = ["People on Beach", "People in Water"]
    let flag = ["Black Flag", "Red Flag", "Yellow Flag"]
    let streams = ["Streams"]
    let note = ["text field"]
    
    // air
    var airValue: String = "00"
    var waterValue: String = "10"
    var airAndWater = [String]()
    
    // wind
    var windValue: String = "00"
    var windDirValue: String = "00"
    var speedAndDir = [String]()
    
    var newDirValue = ""
    let directions = ["North", "North North East", "North East", "East North East",
                      "East", "East South East", "South East", "South South East",
                      "South", "South South West", "South West", "West South West",
                      "West", "West North West", "North West", "North North West"]
    
    // people
    var onBeach: String = "100"
    var inWater: String = "100"
    var onAndin = [String]()
    
    // flag and streams
    var flagValue: String = ""
    var blackFlag: String = ""
    var redFlag: String = ""
    var yellowFlag: String = ""
    
    var streamsValue: String = "No"
    
    // note
    var noteTextFieldHolder: String = ""
    
    
    // custom cell file
    var fieldTableViewCell = FieldTableViewCell()
    
    //    Weather delegate
    var weather = Weather()
    let locationManager = CLLocationManager()
    
    //    Realm database
    let realm = try! Realm()
    //    Realm Array object
    var itemslogbook: Results<ItemLogbook>?
    //    get from ItemTableView
    var selectedItemLogbook: CategoryLogbook?
    
    // date
    let date = Date()
    let formatter = DateFormatter()
    
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // change nav title color
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2736076713, green: 0.249892056, blue: 0.5559395552, alpha: 1)]
        
        // add all weather value i arrayer
        airAndWater = [airValue, waterValue]
        speedAndDir = [windValue, windDirValue]
        onAndin = [onBeach, inWater]
        
        
        // register custom cell
        tableView.register(FieldTableViewCell.nib(), forCellReuseIdentifier: FieldTableViewCell.identifier)
        
        
        // Weather Location delegate
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weather.delegate = self
        
        
    }
    
    
    //MARK: - save pressed
    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        print("save pressed")
        
        if let currentCategory = self.selectedItemLogbook {
            do{
                try self.realm.write{
                    
                    // new item
                    let newItem = ItemLogbook()
                    
                    formatter.dateStyle = .medium //"HH:mm  E , d MMM"
                    formatter.timeStyle = .short
                    let newDate = formatter.string(from: date)
                    
                    newItem.title = newDate
                    newItem.date = Date()
                    newItem.air_temp = airValue
                    newItem.water_temp = waterValue
                    newItem.wind_speed = windValue
                    newItem.wind_direction = windDirValue
                    newItem.people_in_water = inWater
                    newItem.people_on_beach = onBeach
                    newItem.flag = flagValue
                    newItem.streams = streamsValue
                    newItem.note = noteTextFieldHolder
                    
                    //added to array in category database
                    currentCategory.items.append(newItem)
                }
            }catch{
                print("Error saving new Item \(error)")
            }
        }
        //  back to previous page and refresh tableView with segue
        self.performSegue(withIdentifier: "backsegue", sender: self)
        
    }
    
    //MARK: - TextField
    
    // text field end and return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.text != ""{
            noteTextFieldHolder = textField.text!
        }else{
            noteTextFieldHolder = textField.placeholder!
        }
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if textField.text != ""{
            noteTextFieldHolder = textField.text!
        }else{
            noteTextFieldHolder = textField.placeholder!
        }
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return temperature.count
        }else if section == 1{
            return wind.count
        }else if  section == 2{
            return people.count
        }else if  section == 3{
            return flag.count
        }else if  section == 4{
            return streams.count
        }else{
            return note.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath)
        // Configure the cell...
        
        //Stepper
        let myStepper = UIStepper()
        myStepper.autorepeat = true
        
        //Switch
        let mySwitch = UISwitch()
        
        // Air
        if indexPath.section == 0 {
            
            cell.accessoryView = myStepper
            myStepper.tag = indexPath.row
            myStepper.maximumValue = 50
            myStepper.minimumValue = -50
            myStepper.value = Double(airAndWater[indexPath.row]) ?? 00 //Double(airValue) ?? 0.0
            
            myStepper.addTarget(self, action: #selector(didChangeStepperAir(_:)), for: .valueChanged)
            
            cell.textLabel?.text = temperature[indexPath.row]
            cell.detailTextLabel?.text = "\(airAndWater[indexPath.row]) °C" //"\(airValue)"
            if myStepper.tag == 0{
                cell.imageView?.image = UIImage(systemName: "thermometer.sun")
            }else{
                cell.imageView?.image = UIImage(systemName: "thermometer.snowflake")
            }
            
            
            // wind
        }else if indexPath.section == 1{
            
            cell.accessoryView = myStepper
            myStepper.tag = indexPath.row
            myStepper.wraps = true
            myStepper.maximumValue = 15
            myStepper.minimumValue = 0
            myStepper.value = Double(speedAndDir[indexPath.row]) ?? 00 //Double(airValue) ?? 0.0
            
            // call stepper func
            myStepper.addTarget(self, action: #selector(didChangeStepperWind(_:)), for: .valueChanged)
            
            // add text and detail to cell row
            cell.textLabel?.text = wind[indexPath.row]
            cell.detailTextLabel?.text = "\(speedAndDir[indexPath.row]) m/s" //"\(airValue)"
            
            if myStepper.tag == 0{
                cell.imageView?.image = UIImage(systemName: "wind")
            }else{
                cell.imageView?.image = UIImage(systemName: "arrowshape.turn.up.left.circle")
            }
            
            // change wind direction by user
            if indexPath.row == 1 {
                for _ in speedAndDir{
                    
                    let strval = speedAndDir[1]
                    let intval = Int(strval) ?? -1
                    
                    if intval >= 0 {
                        newDirValue = directions[intval]
                        windDirValue = newDirValue
                        speedAndDir = [windValue, windDirValue]
                    }
                }
                cell.detailTextLabel?.text = speedAndDir[1]
            }
            
            // people
        }else if  indexPath.section == 2{
            
            cell.accessoryView = myStepper
            myStepper.tag = indexPath.row
            myStepper.maximumValue = 10000
            myStepper.minimumValue = 0
            myStepper.stepValue = 10
            myStepper.value = Double(onAndin[indexPath.row]) ?? 00 //Double(airValue) ?? 0.0
            
            myStepper.addTarget(self, action: #selector(didChangeStepperPeople(_:)), for: .valueChanged)
            
            cell.textLabel?.text = people[indexPath.row]
            cell.detailTextLabel?.text = onAndin[indexPath.row] //"\(airValue)"
            
            
            cell.imageView?.image = UIImage(systemName: "person.2")
           
            
            
            // flags
        }else if  indexPath.section == 3{
            cell.textLabel?.text = flag[indexPath.row]
            cell.detailTextLabel?.text = "No/Yes"
            cell.accessoryView = mySwitch
            mySwitch.isOn = false
            mySwitch.tag = indexPath.row
            mySwitch.addTarget(self, action: #selector(didChangeSwitchFlag(_:)), for: .valueChanged)
            
            cell.imageView?.image = UIImage(systemName: "flag")
            
            //streams
        }else if  indexPath.section == 4{
            cell.textLabel?.text = streams[indexPath.row]
            cell.detailTextLabel?.text = "No/Yes"
            cell.accessoryView = mySwitch
            mySwitch.isOn = false
            
            mySwitch.addTarget(self, action: #selector(didChangeSwitchStreams(_:)), for: .valueChanged)
            
            cell.imageView?.image = UIImage(systemName: "tornado")
            
        }else{
            // note
            let fieldCell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.identifier, for: indexPath) as! FieldTableViewCell
            
            // set custom cell as delegate
            fieldCell.field.delegate = self
            fieldCell.field.placeholder = noteTextFieldHolder
            
            return fieldCell
        }
        
        return cell
    }
    
    // add title header to section taible view
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        
        if section == 0 {
            return "Tempratur"
        }else if  section == 1{
            return "Wind"
        }else if  section == 2{
            return "People"
        }else if  section == 3{
            return "Flag"
        }else if  section == 4{
            return "Streams"
        }else{
            return "Note"
        }
    }
    
    
    //MARK: - check func
    
    // check Switch flag func in table view
    @objc func didChangeSwitchFlag(_ sender: UISwitch){
        
        if sender.isOn{
            if sender.tag == 0 {
                blackFlag = "Black"
                
            }else if sender.tag == 1 {
                redFlag = "Red"
                
            }else {
                yellowFlag = "Yellow"
                
            }
        }else if sender.isOn == false{
            
            print("is off")
            if sender.tag == 0 {
                blackFlag = ""
                
            }else if sender.tag == 1 {
                redFlag = ""
                
            }else {
                yellowFlag = ""
                
            }
        }
        flagValue = "\(blackFlag) \(redFlag) \(yellowFlag)"
        print(flagValue)
        
    }
    
    // Streams switch func
    @objc func didChangeSwitchStreams(_ sender: UISwitch){
        if sender.isOn {
            streamsValue = "Yes"
        }else{
            streamsValue = "No"
            
        }
    }
    
    
    // air and water Stepper func
    @objc func didChangeStepperAir(_ sender: UIStepper){
        
        if sender.tag == 0 {
            //            print(sender.tag)
            airValue = Int(sender.value).description
        }else {  // tag 1
            waterValue = Int(sender.value).description
        }
        airAndWater = [airValue, waterValue]
        
        tableView.reloadData()
    }
    
    // wind Stepper func
    @objc func didChangeStepperWind(_ sender: UIStepper){
        
        if sender.tag == 0 {
            windValue = Int(sender.value).description
        }else {  // tag 1
            windDirValue = Int(sender.value).description
        }
        speedAndDir = [windValue, windDirValue]
        
        tableView.reloadData()
    }
    
    // wind Stepper func
    @objc func didChangeStepperPeople(_ sender: UIStepper){
        
        if sender.tag == 0 {
            onBeach = Int(sender.value).description
        }else {  // tag 1
            inWater = Int(sender.value).description
        }
        onAndin = [onBeach, inWater]
        
        tableView.reloadData()
    }
    
    
}



// MARK - Weather Location
extension ReportTableViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weather.fetchWeather(latitude: lat, longitude: lon)
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
}


// MARK - Weather by City
extension ReportTableViewController: WeatherDelegate {
    func didUpdateWeather(_ weatherManeger: Weather, weather: WeatherModel) {
        DispatchQueue.main.async {
            
            // add weather info to lable text
            self.airValue = weather.tempString
            self.windValue = weather.windString
            self.noteTextFieldHolder = "\(weather.cityName) \(weather.description)"
            self.windDirValue = weather.winDirString
            
            self.airAndWater = [self.airValue, self.waterValue]
            self.speedAndDir = [self.windValue, self.windDirValue]
            self.tableView.reloadData()
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}



//extension ReportTableViewController: FieldTableViewCellDelegate {
//    func getTextField(getText: String) {
//        noteTextField = getText
//    }
//
//
//}
