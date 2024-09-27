//
//  weatherInfoView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherInfoView: View {
    
    var body: some View {
        VStack(spacing: 6) {
            Text("Seoul").setTextTitleStyle(size: Fonts.userPlace)
            Text("-7").setTextTitleStyle(size: Fonts.userTemperature)
            Text("맑음").setTextTitleStyle(size: Fonts.userWeather)
            Text("최고: -1 | 최저: -11").setTextTitleStyle(size: Fonts.userTempRange)
        }
        .padding(.vertical, Padding.weatherHorizontalPadding)
    }
}

#Preview {
    WeatherInfoView()
}
