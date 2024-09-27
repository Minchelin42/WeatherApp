//
//  day5WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI


struct Day5WeatherView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: Padding.weatherHorizontalPadding)
            Text("5일간의 일기예보").setTextTitleStyle(size: Fonts.weatherCellTitle)
            ForEach(0..<5) { _ in
                HorizontalWeatherCell()
            }
            Spacer().frame(height: Padding.weatherHorizontalPadding)
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 270)
    }
}

struct HorizontalWeatherCell: View {
    
    var body: some View {
        
        VStack {
            seperateLine()
            HStack(spacing: 3) {
                Text("지금").setTextTitleStyle(size: Fonts.weatherCell5DayInfo)
                Spacer()
                Image("01d")
                    .resizable()
                    .frame(width: 25, height: 25)
                Spacer()
                Text("최소: -1°  최대: -7°").setTextTitleStyle(size: Fonts.weatherCell5DayInfo)
            }
        }

    }
}

#Preview {
    Day5WeatherView()
}
