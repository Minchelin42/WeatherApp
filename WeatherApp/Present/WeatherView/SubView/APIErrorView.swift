//
//  APIErrorView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import SwiftUI

struct APIErrorView: View {
    var body: some View {
        VStack {
            Image("03d")
            Text("현재 날씨 정보를 불러올 수 없습니다").setTextLargeTitleStyle(size: 20).padding(.bottom, 2)
            Text("앱 종료 후 다시 시도해보세요").setTextTitleStyle(size: 14)
        }
        .frame(maxHeight: .infinity)
    }
}
