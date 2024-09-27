//
//  SearchView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/27/24.
//

import SwiftUI

struct SearchView: View {
    var body: some View {
        ZStack {
            Color.mainColor
                .ignoresSafeArea()
            VStack {
                WeatherSearchBar(text: "")
                Spacer().frame(height: 16)
                ScrollView() {
                    ForEach(0..<30) { _ in
                        CityCell()
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.horizontal, Padding.weatherHorizontalPadding)
        }
    }
}


struct CityCell: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Seoul").setTextBigStyle(size: 16)
            Text("KR").setTextBigStyle(size: 12)
            seperateLine()
        }
    }
}

#Preview {
    SearchView()
}
