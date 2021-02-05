//
//  Weather.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-19.
//

import Foundation

protocol WeatherDelegate {
    func didUpdateWeather(_ weatherManeger: Weather, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct Weather {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=b6f0b50f126a925ae85a846d3f99770a&units=metric"
    
    var delegate: WeatherDelegate?
    
    
    func fetchWeather(cityName: String){
        let URLapi = "\(weatherURL)&q=\(cityName)"
        perfomRequest(urlString: URLapi)
    }
    func fetchWeather(latitude: Double, longitude: Double) {
        let URLapi = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        perfomRequest(urlString: URLapi)
    }
    
    func perfomRequest(urlString: String){
        //1. Creat a URL
        if let url = URL(string: urlString){
            //2. Creat a URL Session
            let session = URLSession(configuration: .default)
            
            //3. Give the sission task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
        
        
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let description = decodedData.weather[0].description
            let name = decodedData.name
            let temp = decodedData.main.temp
            let wind = decodedData.wind.speed
            let winddir = decodedData.wind.deg
        
            
            
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp, windSpeed: wind, description: description, windDirection: winddir)
            return weather
            
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
        
        
    }
    
}




