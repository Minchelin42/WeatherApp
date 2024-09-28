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
            Spacer().frame(height: Padding.weatherHorizontalPadding)
            Text("5일간의 일기예보").setTextTitleStyle(size: Fonts.weatherCellTitle)
            ForEach(day5Weather, id: \.self) { weather in
                HorizontalWeatherCell(weather: weather)
            }
            Spacer().frame(height: Padding.weatherHorizontalPadding)
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 270)
    }
}

struct HorizontalWeatherCell: View {
    
    var weather: minMaxWeatherInfo
    
    var body: some View {
        
        VStack {
            seperateLine()
            HStack(spacing: 3) {
                Text(weather.day).setTextTitleStyle(size: Fonts.weatherCell5DayInfo).frame(width: 32, alignment: .leading)
                Spacer()
                Image(weather.weatherIcon)
                    .resizable()
                    .frame(width: 32, height: 32)
                Spacer()
                Text("최소: \(weather.temp_min)°     최대: \(weather.temp_max)°").setTextTitleStyle(size: Fonts.weatherCell5DayInfo)
            }
        }

    }
}

//#Preview {
//    Day5WeatherView()
//}
