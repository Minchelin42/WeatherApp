//
//  day2WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//


import SwiftUI

struct seperateLine: View {
    
    var body: some View {
        Color.whiteFont
        .frame(maxWidth: .infinity)
        .frame(height: 0.5)
    }
}

struct Day2WeatherView: View {
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: Padding.weatherHorizontalPadding)
            Text("돌풍의 풍속은 최대 4m/s 입니다").setTextTitleStyle(size: Fonts.weatherCellTitle)
            seperateLine()
            ScrollView(.horizontal) {
                HStack(spacing: 0) {
                    ForEach(0..<10) { _ in
                        VerticalWeatherCell()
                    }
                }
                .frame(maxWidth: .infinity)
            }
            Spacer().frame(height: Padding.weatherHorizontalPadding)
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 120)

    }
}

struct VerticalWeatherCell: View {
    
    var body: some View {
        VStack(spacing: 3) {
            Text("오후 12시").setTextTitleStyle(size: Fonts.weatHerCell2DayInfo)
            Image("01d")
                .resizable()
                .frame(width: 25, height: 25)
            Text("-1°").setTextTitleStyle(size: Fonts.weatHerCell2DayInfo)
        }
        .frame(maxWidth: 80)
        .padding(.horizontal, 8)
    }
}

#Preview {
    Day2WeatherView()
}
