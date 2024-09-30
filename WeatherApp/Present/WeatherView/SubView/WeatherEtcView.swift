//
//  weatherEtcView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

enum weatherEtc {
    case humidity(title: String, unit: String)
    case cloud(title: String, unit: String)
    case windSpeed(title: String, unit: String)
    
    func etcTitle() -> String {
        switch self {
        case .humidity(let title, _), .cloud(let title, _), .windSpeed(let title, _):
            return title
        }
    }
    
    func etcInfo<T: Numeric>(value: T) -> String {
        switch self {
        case .humidity(_, let unit), .cloud(_, let unit), .windSpeed(_, let unit):
            return "\(value)\(unit)"
        }
    }
}

struct WeatherEtcCell: View {
    
    var etcType: weatherEtc
    var value: any Numeric
    
    let frameSize = (UIScreen.main.bounds.width - (Padding.weatherHorizontalPadding * 3)) / 2
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(etcType.etcTitle()).setTextTitleStyle(size: Fonts.weatherCellSub)
                Spacer()
            }
            Spacer()
            HStack {
                Text(etcType.etcInfo(value: value)).setTextTitleStyle(size: Fonts.etcCellInfo)
                Spacer()
            }
            Spacer()
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .padding(.vertical, Padding.weatherVerticalPadding)
        .frame(width: frameSize, height: frameSize, alignment: .leading)
        .background(Color.mainColor)
        .cornerRadius(12)
    }
    
}

struct WeatherEtcView: View {
    
    var weather: TodayWeatherModel
    
    var body: some View {
        VStack() {
            HStack() {
                WeatherEtcCell(etcType: .humidity(title: "습도", unit: "%"), value: weather.humidity)
                Spacer()
                WeatherEtcCell(etcType: .cloud(title: "구름", unit: "%"), value: weather.clouds)
            }
            
            Spacer().frame(height: 16)
            
            HStack {
                    WeatherEtcCell(etcType: .windSpeed(title: "바람 속도", unit: "m/s"), value: weather.windSpeed)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}
