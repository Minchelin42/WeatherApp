//
//  day5WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI


struct Day5WeatherView: View {
    
    var day5Weather: [minMaxWeatherInfo]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("5일간의 일기예보").setTextTitleStyle(size: Fonts.weatherCellTitle)
            ForEach(day5Weather, id: \.id) { weather in
                HorizontalWeatherCell(weather: weather)
            }
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .padding(.vertical, Padding.weatherVerticalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 270)
    }
}

struct HorizontalWeatherCell: View {
    
    var weather: minMaxWeatherInfo
    
    var body: some View {
        
        VStack {
            SeperateLine()
            HStack(spacing: 3) {
                Text(weather.day).setTextTitleStyle(size: Fonts.weatherCell5DayInfo).frame(width: 32, alignment: .leading)
                Spacer()
                Image(weather.weatherIcon)
                    .resizable()
                    .frame(width: 32, height: 32)
                    .aspectRatio(contentMode: .fill)
                Spacer()
                Spacer()
                Text("최소: \(weather.temp_min)°").setTextTitleStyle(size: Fonts.weatherCell5DayInfo).frame(width: 60, alignment: .leading)
                Spacer().frame(width: 20)
                Text("최대: \(weather.temp_max)°").setTextTitleStyle(size: Fonts.weatherCell5DayInfo).frame(width: 60, alignment: .leading)
            }
        }

    }
}

