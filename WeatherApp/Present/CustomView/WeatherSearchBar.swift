//
//  WeatherSearchBar.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherSearchBar: View {
    
    @State var text: String = ""
    
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            AppImage.searchImg.foregroundColor(Color.grayFont)
            TextField("도시명으로 검색", text: $text) {
                
            }
            .frame(height: 36)
        }
        .setBackgroundStyle(color: Color.searchColor, cornerRadius: 8, height: 36)
    }
}

#Preview {
    WeatherSearchBar(text: "")
}
