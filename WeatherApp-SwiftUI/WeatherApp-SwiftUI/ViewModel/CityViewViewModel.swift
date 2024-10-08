//
//  WeatherViewModel.swift
//  WeatherApp-SwiftUI
//
//  Created by Reddy Bharadwaj Chowdary on 07/01/24.
//



import SwiftUI
import CoreLocation


final class WeatherViewModel: ObservableObject {
    
    @Published var weatherModel = WeatherModel.empty()
    
    @Published var city: String = "San Francisco" {
        
        didSet {
            
            getLocation()
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        return formatter
    }()
    
    private lazy var dayFormatter: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter
    }()
    
    
    init() {
        
        getLocation()
    }
    
    var date: String {
        
        return dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(weatherModel.current.dt)))
    }
    
    var weatherIcon: String {
        
        if weatherModel.current.weather.count > 0 {
            
            return weatherModel.current.weather[0].icon
        }
        
        return "dayClearSky"
    }
    
    var DailyWeatherTemp: String {
        
        return getTempFor(temp: weatherModel.current.temp)
    }
    
    var conditions: String {
        
        if weatherModel.current.weather.count > 0 {
            
            return weatherModel.current.weather[0].main
        }
        
        return ""
    }
    
    var windSpeed: String {
        
        return String(format: "%0.1f", weatherModel.current.wind_speed / 1.60934)
    }
    
    var humidity: String {
        
        return String(format: "%d%%", weatherModel.current.humidity)
    }
    
    var rainChances: String {
        
        return String(format: "%0.0f%%", weatherModel.current.dew_point)
    }
    
    
    func getTempFor(temp: Double) -> String {
        
        return String(format: "%0.1f", 5.0/9*(temp-32))
    }
    
    func getDayFor(timestamp: Int) -> String {
        
        return dayFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(timestamp)))
    }
    
    private func getLocation() {
        
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            
            if let places = placemarks, let place = places.first {
                
                self.getWeather(coord: place.location?.coordinate)
            }
        }
    }
    
    private func getWeather(coord: CLLocationCoordinate2D?) {
        
        if let coord = coord {
            
            let urlString = API.getURLFor(lat: coord.latitude, lon: coord.longitude)
            getWeatherInternal(city: city, for: urlString)
        
        } else {
            
            let urlString = API.getURLFor(lat: 37.5485, lon: -121.9886)
            getWeatherInternal(city: city, for: urlString)
        }
    }
    
    private func getWeatherInternal(city: String, for urlString: String) {
        
        NetworkManager<WeatherModel>.fetch(for: URL(string: urlString)!) { (result) in
            
            switch result {
            
            case .success(let response):
                
                DispatchQueue.main.async {
                    
                    self.weatherModel = response
                }
                
            case .failure(let err):
                print(err)
            }
        }
    }
    
    func getLottieAnimationFor(icon: String) -> String {
        
        switch icon {
        
        case "01d":
            return "dayClearSky"
            
        case "01n":
            return "nightClearSky"
            
        case "02d":
            return "dayFewClouds"
            
        case "02n":
            return "nightFewClouds"
            
        case "03d":
            return "dayScatteredClouds"
            
        case "03n":
            return "nightScatteredClouds"
            
        case "04d":
            return "dayBrokenClouds"
            
        case "04n":
            return "nightBrokenClouds"
            
        case "09d":
            return "dayShowerRains"
            
        case "09n":
            return "nightShowerRains"
            
        case "10d":
            return "dayRain"
            
        case "10n":
            return "nightRain"
            
        case "11d":
            return "dayThunderstorm"
            
        case "11n":
            return "nightThunderstorm"
            
        case "13d":
            return "daySnow"
            
        case "13n":
            return "nightSnow"
            
        case "50d":
            return "dayMist"
            
        case "50n":
            return "nightMist"
            
        default:
            return "dayClearSky"
        }
    }
    
    func getWeatherIconFor(icon: String) -> Image {
        
        switch icon {
        
        case "01d":
            return Image(systemName: "sun.max.fill") // "clear_sky_day"
            
        case "01n":
            return Image(systemName: "moon.fill") // "clear_sky_night"
            
        case "02d":
            return Image(systemName: "cloud.sun.fill") // "few_clouds_day"
            
        case "02n":
            return Image(systemName: "cloud.moon.fill") // "few_clouds_night"
            
        case "03d":
            return Image(systemName: "cloud.fill") // "scattered_clouds"
            
        case "03n":
            return Image(systemName: "cloud.fill") // "scattered_clouds"
            
        case "04d":
            return Image(systemName: "cloud.fill") // "broken_clouds"
            
        case "04n":
            return Image(systemName: "cloud.fill") // "broken_clouds"
            
        case "09d":
            return Image(systemName: "cloud.drizzle.fill") // "shower_rain"
            
        case "09n":
            return Image(systemName: "cloud.drizzle.fill") // "shower_rain"
            
        case "10d":
            return Image(systemName: "cloud.heavyrain.fill") // "rain_day"
            
        case "10n":
            return Image(systemName: "cloud.heavyrain.fill") // "rain_night"
            
        case "11d":
            return Image(systemName: "cloud.bolt.fill") // "thunderstorm_day"
            
        case "11n":
            return Image(systemName: "cloud.bolt.fill") // "thunderstorm_night"
            
        case "13d":
            return Image(systemName: "cloud.snow.fill") // "snow"
            
        case "13n":
            return Image(systemName: "cloud.snow.fill") // "snow"
            
        case "50d":
            return Image(systemName: "cloud.fog.fill") // "mist"
            
        case "50n":
            return Image(systemName: "cloud.fog.fill") // "mist"
            
        default:
            return Image(systemName: "sun.max.fill")
        }
    }
    
}
