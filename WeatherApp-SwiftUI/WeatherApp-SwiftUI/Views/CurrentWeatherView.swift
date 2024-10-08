//
//  CurrentWeatherView.swift
//  WeatherApp-SwiftUI
//
//  Created by Reddy Bharadwaj Chowdary on 07/01/24.
//

import SwiftUI

struct CurrentWeatherView: View {
    
    @ObservedObject var cityVM: WeatherViewModel

    var body: some View {

        VStack(spacing: 10) {
            
            Text("Today")
                .font(.largeTitle)
                .bold()
            
                
                VStack(alignment: .leading) {
                    
                    Text("\(cityVM.DailyWeatherTemp)℃")
                        .font(.system(size: 42))
                    
                    Text(cityVM.conditions)
                }
            
            HStack {
                
                Spacer()
                
                widgetView(image: "wind", color: .green, title: "\(cityVM.windSpeed)km/hr")
                
                Spacer()
                
                widgetView(image: "drop.fill", color: .blue, title: "\(cityVM.humidity)")
                
                Spacer()
                
                widgetView(image: "umbrella.fill", color: .red, title: "\(cityVM.rainChances)")
                
                Spacer()
            }
        }
        .padding()
        .foregroundColor(.white)
        .background(RoundedRectangle(cornerRadius: 20).fill(LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.5), Color.blue]), startPoint: .top, endPoint: .bottom)).opacity(0.3))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
    
    private func widgetView(image: String, color: Color, title: String) -> some View {
        
        VStack {
            
            Image(systemName: image)
                .padding()
                .font(.title)
                .foregroundColor(color)
                .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
            
            Text(title)
        }
    }
}


#Preview {
    CurrentWeatherView(cityVM: <#T##WeatherViewModel#>)
}
