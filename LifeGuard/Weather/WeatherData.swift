//
//  WeatherData.swift
//  LifeGuard
//
//  Created by Atlal Basha on 2021-01-19.
//

import Foundation

// get weather data from JSON
struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [WeatherCase]
    let wind: Wind
    
}

struct Main: Codable {
    let temp: Double
}

struct WeatherCase: Codable {
    let description: String
    let id: Int
}

struct Wind: Codable {
    let speed: Double
    let deg: Float
    
}








