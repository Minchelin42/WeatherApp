//
//  ContentView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/25/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var text: String = ""
    
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            AppImage.searchImg.foregroundColor(Color.grayFont)
            TextField("도시명으로 검색", text: $text) {
                
            }
        }
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 50)
    }
}

#Preview {
    ContentView(text: "")
}
