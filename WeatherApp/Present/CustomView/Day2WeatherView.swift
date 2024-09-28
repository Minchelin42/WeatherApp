//
//  day2WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//


import SwiftUI

struct Day2WeatherView: View {
    
    var day2Weather: [WeatherForecastModel]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("시간대별 일기예보").setTextTitleStyle(size: Fonts.weatherCellTitle)
            SeperateLine()
            ScrollView(.horizontal) {
                HStack(spacing: 2) {
                    ForEach(day2Weather, id: \.id) { weather in
                        VerticalWeatherCell(weather: weather)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .padding(.vertical, Padding.weatherHorizontalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 120)

    }
}

struct VerticalWeatherCell: View {
    
    var weather: WeatherForecastModel
    
    var body: some View {
        VStack(spacing: 3) {
            Text("\(weather.date)").setTextTitleStyle(size: Fonts.weatHerCell2DayInfo)
            Image(weather.weatherIcon)
                .resizable()
                .frame(width: 25, height: 25)
                .aspectRatio(contentMode: .fill)
            Text("\(weather.temp)°").setTextTitleStyle(size: Fonts.weatHerCell2DayInfo)
        }
        .frame(maxWidth: 80)
        .padding(.horizontal, 8)
    }
}

//#Preview {
//    Day2WeatherView()
//}
