//
//  DailyWeatherFile.swift
//  WeatherApp-SwiftUI
//
//  Created by Reddy Bharadwaj Chowdary on 07/01/24.
//

import Foundation


struct DailyWeather: Codable, Identifiable {
    
    var dt: Int
    var temp: DailyWeatherTemp
    var weather: [DailyWeatherDetail]
    
    
    enum CodingKey: String {
        
        case dt
        case temp
        case weather
    }
    
    init() {
        
        dt = 0
        temp = DailyWeatherTemp(min: 0.0, max: 0.0)
        weather = [DailyWeatherDetail(main: "", description: "", icon: "")]
    }
}


extension DailyWeather {
    
    var id: UUID {
        
        return UUID()
    }
}
