//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            Color.mainColor
                .ignoresSafeArea()
            
            ScrollView() {
                VStack(spacing: 16) {
                    WeatherSearchBar(text: "")
                    WeatherInfoView()
                    Day2WeatherView()
                    Day5WeatherView()
                    WeatherMapView()
                    WeatherEtcView()
                }
                .padding(.horizontal, Padding.weatherHorizontalPadding)
                .frame(maxHeight: .infinity)
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    WeatherView()
}
