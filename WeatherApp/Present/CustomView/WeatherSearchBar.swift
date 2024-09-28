//
//  WeatherSearchBar.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherSearchBar: View {
    
    @Binding var text: String
    var tfInactive: Bool
    
    init(text: Binding<String> = .constant(""), tfInactive: Bool) {
        self._text = text
        self.tfInactive = tfInactive
    }
    
    var body: some View {
        HStack {
            Spacer().frame(width: 10)
            AppImage.searchImg.foregroundColor(Color.grayFont)
            TextField("도시명으로 검색", text: $text)
            .frame(height: 36)
            .disabled(tfInactive)
        }
        .setBackgroundStyle(color: Color.searchColor, cornerRadius: 8, height: 36)
    }
}

