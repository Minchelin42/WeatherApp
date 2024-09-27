//
//  weatherEtcView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

enum weatherEtc: String {
    case humidity = "습도"
    case cloud = "구름"
    case windSpeed = "바람 속도"
    case pressure = "기압"
}

struct WeatherEtcCell: View {
    
    @State var etcType: weatherEtc = .humidity
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: Padding.weatherHorizontalPadding)
            HStack {
                Text(etcType.rawValue).setTextTitleStyle(size: Fonts.weatherCellSub)
                Spacer()
            }
            Spacer()
            HStack {
                Text("56%").setTextTitleStyle(size: Fonts.etcCellInfo)
                Spacer()
            }
            
            if etcType == .windSpeed {
                Spacer()
                HStack {
                    Text("강풍: 3.39m/s").setTextTitleStyle(size: Fonts.weatherCellSub)
                    Spacer()
                }
            }
            Spacer().frame(height: Padding.weatherHorizontalPadding)
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .frame(width: 170, height: 170, alignment: .leading)
        .background(Color.mainColor)
        .cornerRadius(12)
    }
    
}

struct WeatherEtcView: View {
    
    var body: some View {
        VStack() {
            HStack() {
                WeatherEtcCell()
                Spacer()
                WeatherEtcCell()
            }
            
            Spacer().frame(height: 16)
            
            HStack {
                WeatherEtcCell(etcType: .windSpeed)
                Spacer()
                WeatherEtcCell()
            }
        }
        .frame(maxWidth: .infinity)
    }
    
}

#Preview {
    WeatherEtcView()
}
