//
//  AddLogBookViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-22.
//

import UIKit
import CoreLocation
import RealmSwift




class AddItemViewController: UIViewController{
    
    
    
    //    Realm database
    let realm = try! Realm()
    //    Realm Array object
    var itemslogbook: Results<ItemLogbook>?
    
    //    get from ItemTableView
    var selectedItemLogbook: CategoryLogbook?
    
    
    var airTemp_value: String?
    var waterTemp_value: String = "10"
    
    var windSpeed_value: String?
    var windDirection_value: String?
    
    var peopleInWater: String = "100"
    var peopleOnBeach: String = "100"
    
    var flag_value: String?
    var streams_value: String?
    
    var note_value: String?
    
    
    
    
    //    Weather delegate
    var weather = Weather()
    let locationManager = CLLocationManager()
    
    //    Date lable
    @IBOutlet weak var dateText: UILabel!
    let date = Date()
    let formatter = DateFormatter()
    
    //    Air temp
    @IBOutlet weak var airTempText: UILabel!
    @IBAction func airStepper(_ sender: UIStepper) {
        
        
        airTempText.text = Int(sender.value).description
        airTemp_value = airTempText.text!
        
    }
    
    
    
    //    Water temp
    @IBOutlet weak var waterTempText: UILabel!
    @IBAction func waterStepper(_ sender: UIStepper) {
        waterTempText.text = Int(sender.value).description
        waterTemp_value = waterTempText.text!
    }
    
    
    //    Wind Speed
    @IBOutlet weak var windSpeedText: UILabel!
    @IBAction func windSpeedStepper(_ sender: UIStepper) {
        
        windSpeedText.text = Int(sender.value).description
        windSpeed_value = windSpeedText.text!
    }
    
    
    //    Wind Direction
    @IBOutlet weak var windDir: UILabel!
    @IBAction func windDirStepper(_ sender: UIStepper) {
        //        windDir.text = Int(sender.value).description
        
        let directions = ["North", "North North East", "North East", "East North East",
                          "East", "East South East", "South East", "South South East",
                          "South", "South South West", "South West", "West South West",
                          "West", "West North West", "North West", "North North West"]
        let changeWindDir = directions[Int(sender.value)]
        windDir.text = changeWindDir
        windDirection_value = windDir.text!
    }
    
    
    //    On Beach
    @IBOutlet weak var onBeachText: UILabel!
    @IBAction func onBeachStepper(_ sender: UIStepper) {
        onBeachText.text = Int(sender.value).description
        peopleOnBeach = onBeachText.text!
    }
    
    
    //    in Sea
    @IBOutlet weak var inSeaText: UILabel!
    @IBAction func inSeaStepper(_ sender: UIStepper) {
        inSeaText.text = Int(sender.value).description
        peopleInWater = inSeaText.text!
    }
    
    
    //    Flag
    @IBOutlet weak var blackFlagSwitch: UISwitch!
    @IBOutlet weak var redFlagSwitch: UISwitch!
    @IBOutlet weak var yellowFlagswitch: UISwitch!
    //    Streams
    @IBOutlet weak var streamSwitch: UISwitch!
    
    
    //    other text field
    @IBOutlet weak var otherTextField: UITextField!
    
    
    
    
    
    
    //    MARK: - View DidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        // add navigation bar programaticly
        let width = self.view.frame.width
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
        
        navigationBar.barTintColor = #colorLiteral(red: 0.2736076713, green: 0.249892056, blue: 0.5559395552, alpha: 1)
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.view.addSubview(navigationBar);
        let navigationItem = UINavigationItem(title: "Add Report")
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: nil, action: #selector(donePressed))
        
        let cancelBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: nil, action: #selector(cancelPressed))
        cancelBtn.tintColor = #colorLiteral(red: 0.9792179465, green: 0.4215875864, blue: 0.4211912155, alpha: 1)
        doneBtn.tintColor = #colorLiteral(red: 0.9792179465, green: 0.4215875864, blue: 0.4211912155, alpha: 1)
        navigationItem.rightBarButtonItem = doneBtn
        navigationItem.leftBarButtonItem = cancelBtn
        navigationBar.setItems([navigationItem], animated: false)
        ///
        
        
        
        
        
        
        // Close iOS Keyboard by touching anywhere
        self.hideKeyboardWhenTappedAround()
        
        // Weather Location delegate
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        weather.delegate = self
        
        // date format
        formatter.dateFormat = "HH:mm  E , d MMM yyyy"
        let result = formatter.string(from: date)
        dateText.text = result
        
        
        // show and hide kyboard
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        
        
        
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    
    
    //----///
    
    @objc func cancelPressed() {
        //        back to previous page
        self.dismiss(animated: true, completion: nil)
    }
   
    @objc func donePressed() {
        // new item object and added to array in database
        if let currentCategory = self.selectedItemLogbook {
            do{
                try self.realm.write{
                    // new item
                    let newItem = ItemLogbook()
                    
                    formatter.dateStyle = .medium //"HH:mm  E , d MMM"
                    formatter.timeStyle = .short
                    let newDate = formatter.string(from: date)
                    
                    if otherTextField.text != ""{
                        note_value = otherTextField.text
                    }
                    
                    newItem.title = newDate
                    newItem.date = Date()
                    newItem.air_temp = airTemp_value!
                    newItem.water_temp = waterTemp_value
                    newItem.wind_speed = windSpeed_value!
                    newItem.wind_direction = windDirection_value!
                    newItem.people_in_water = peopleInWater
                    newItem.people_on_beach = peopleOnBeach
                    newItem.flag = updateFlag()
                    newItem.streams = updateStreams()
                    newItem.note = note_value!
                    
                    
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
    
}






// MARK - Weather Location
extension AddItemViewController: CLLocationManagerDelegate {
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
extension AddItemViewController: WeatherDelegate {
    func didUpdateWeather(_ weatherManeger: Weather, weather: WeatherModel) {
        DispatchQueue.main.async {
            
            //            add weather info to lable text
            self.airTempText.text = weather.tempString
            self.windSpeedText.text = weather.windString
            self.otherTextField.placeholder = "\(weather.cityName) \(weather.description)"
            self.windDir.text = weather.winDirString
            
            //            add weather info to String to added sen to database
            self.airTemp_value = weather.tempString
            self.windSpeed_value = weather.windString
            self.windDirection_value = weather.winDirString
            self.note_value = "\(weather.cityName) \(weather.description)"
            
            
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
    
    
    
    
    //MARK: - Switch func
    //    flag func
    func updateFlag() -> String {
        var blackFlag: String = ""
        var redFlag: String = ""
        var yellowFlag: String = ""
        if blackFlagSwitch.isOn {
            blackFlag = "Black"
        }
        if redFlagSwitch.isOn {
            redFlag = "Red"
        }
        if yellowFlagswitch.isOn {
            yellowFlag = "Yellow"
        }
        flag_value = "\(blackFlag) \(redFlag) \(yellowFlag)"
        return flag_value!
        
    }
    
    //    streams func
    func updateStreams() -> String {
        if streamSwitch.isOn{
            streams_value = "Yes"
        }else{
            streams_value = "NO"
        }
        return streams_value!
    }
    
    
}


