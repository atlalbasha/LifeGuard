//
//  ViewController.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-19.
//

import UIKit
import CoreLocation
import MTSlideToOpen





class WeatherViewController: UIViewController, MTSlideToOpenDelegate {
    
   
    // slid bar button method
    func mtSlideToOpenDelegateDidFinish(_ sender: MTSlideToOpenView) {
        print("slid")
        callNumber(phoneNumber: "112")
        sender.resetStateWithAnimation(false)
        
        
            
    }
    
    
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var cityText: UILabel!
    @IBOutlet weak var tempText: UILabel!
    @IBOutlet weak var conditionImage: UIImageView!
    @IBOutlet weak var windText: UILabel!
    @IBOutlet weak var descText: UILabel!
    @IBOutlet weak var dateText: UILabel!
    @IBOutlet weak var winDirText: UILabel!
    
    
    var weather = Weather()
    let locationManager = CLLocationManager()
    
    let date = Date()
    let formatter = DateFormatter()
    
    
    // call 112 sos func
    private func callNumber(phoneNumber: String) {
        guard let url = URL(string: "telprompt://\(phoneNumber)"),
            UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //slid button
        let slide = MTSlideToOpenView(frame: CGRect(x: 35, y: 700, width: 317, height: 56))
        slide.sliderViewTopDistance = 0
        slide.sliderCornerRadius = 28
        slide.thumbnailColor = #colorLiteral(red: 0.9792179465, green: 0.4215875864, blue: 0.4211912155, alpha: 1)
        slide.slidingColor = #colorLiteral(red: 0.9792179465, green: 0.4215875864, blue: 0.4211912155, alpha: 1)
        slide.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        slide.textFont = .boldSystemFont(ofSize: 18)
        slide.delegate = self
        slide.labelText = "Emergency SOS"
        slide.thumnailImageView.image = #imageLiteral(resourceName: "ic_arrow")
        self.view.addSubview(slide)
        
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        weather.delegate = self
        searchText.delegate = self
        
        formatter.dateStyle = .full  // dateFormat = "EEEE, MMM d, yyyy"
        let result = formatter.string(from: date)
        dateText.text = result
        
    }
    
    
    
    // location pressed
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    
    // search pressed on app
    @IBAction func searchPressed(_ sender: UIButton) {
        searchText.endEditing(true)
        print(searchText.text!)
    }
    
    
    
    
    
}


//MARK: - Weather Location
extension WeatherViewController: CLLocationManagerDelegate {
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




//MARK: - Weather by City
extension WeatherViewController: WeatherDelegate {
    func didUpdateWeather(_ weatherManeger: Weather, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.tempText.text = weather.tempString
            self.windText.text = weather.windString
            self.cityText.text = weather.cityName
            self.descText.text = weather.description
            self.winDirText.text = weather.winDirString
            self.conditionImage.image = UIImage(systemName: weather.conditionName)
        }
        
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}





//MARK: - Text Field
extension WeatherViewController: UITextFieldDelegate {
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchText.endEditing(true)
        print(searchText.text!)
        return true
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if let city = searchText.text?.trimmingCharacters(in: .whitespacesAndNewlines){
            weather.fetchWeather(cityName: city)
        }
        
        searchText.text = ""
    }
    
    
    //    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    //        if searchText.text != ""{
    //            return true
    //        }else{
    //            searchText.placeholder = "Type City Name.."
    //            return false
    //        }
    //    }
}
