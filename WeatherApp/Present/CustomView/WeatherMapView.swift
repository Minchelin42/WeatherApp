//
//  weatherMapView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/27/24.
//

import SwiftUI

struct WeatherMapView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: Padding.weatherHorizontalPadding)
            HStack {
                Text("강수량").setTextTitleStyle(size: Fonts.weatherCellSub)
                Spacer()
            }
            Spacer()
            //나중에 지도 넣을 자리
            Color.whiteFont
                .opacity(0.3)
                .frame(maxWidth: .infinity)
                .frame(height: 320)
            
            Spacer().frame(height: Padding.weatherHorizontalPadding)
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 380)
    }
}

//#Preview {
//    WeatherMapView()
//}
