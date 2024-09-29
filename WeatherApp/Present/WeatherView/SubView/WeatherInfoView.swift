//
//  weatherInfoView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherInfoView: View {
    
    var weather: TodayWeatherModel

    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            Text(weather.city).setTextTitleStyle(size: Fonts.userPlace)
            Text("\(weather.temp)°").setTextTitleStyle(size: Fonts.userTemperature)
            Text(weather.description).setTextTitleStyle(size: Fonts.userWeather)
            Text("최고: \(weather.temp_max)° | 최저: \(weather.temp_min)°").setTextTitleStyle(size: Fonts.userTempRange)
        }
        .padding(.vertical, Padding.weatherVerticalPadding)
    }
}


