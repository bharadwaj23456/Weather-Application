//
//  WeatherModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Reddy Bharadwaj Chowdary on 07/01/24.
//

import Foundation

struct WeatherModel: Codable {
    
    var current: Weather
    var hourly: [Weather]
    var daily: [DailyWeather]
    
    static func empty() -> WeatherModel {
        
        return WeatherModel(current: Weather(), hourly: [Weather](repeating: Weather(), count: 23), daily: [DailyWeather](repeating: DailyWeather(), count: 8))
    }
}
