//
//  WeatherModel.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-20.
//

import Foundation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temprature: Double
    let windSpeed: Double
    let description: String
    let windDirection: Float
    
    
    var tempString: String{
        return String(format: "%.0f", temprature)
    }
    var windString: String{
        return String(format: "%.0f", windSpeed)
    }
    var winDirString: String{
        convertDegreeToCompassPoint(degrees: windDirection)
//        return String(format: "%.0f", windDirection)
    }
    
    
    func convertDegreeToCompassPoint(degrees : Float) -> String {

//      let directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        
      let directions = ["North", "North North East", "North East", "East North East",
                        "East", "East South East", "South East", "South South East",
                        "South", "South South West", "South West", "West South West",
                        "West", "West North West", "North West", "North North West"]
        
      let i: Int = Int((degrees + 11.25)/22.5)
      return directions[i % 16]
  }
    
    
    var conditionName: String{
        switch conditionId {
        case 200...232:
            return "cloud.bolt"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
        
    }
    
    
}
