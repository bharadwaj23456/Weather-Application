//
//  CityStatusView.swift
//  WeatherApp-SwiftUI
//
//  Created by Reddy Bharadwaj Chowdary on 07/01/24.
//

import SwiftUI

struct CityStatusView: View {
    
    @ObservedObject var cityVM: WeatherViewModel

    var body: some View {

        VStack {
            
            CityNameView(city: cityVM.city, date: cityVM.date)
                .shadow(radius: 0)
            
            CurrentWeatherView(cityVM: cityVM)
                .padding()
            
            
            DailyWeatherView(cityVM: cityVM)
        }
        .padding(.bottom, 30)
    }

}
