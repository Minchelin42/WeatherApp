//
//  setTextTitleStyle.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//


import SwiftUI

private struct setTextMediumWhiteStyle: ViewModifier {
    
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
            .fontWeight(.medium)
            .foregroundColor(Color.whiteFont)
    }
    
}


extension View {
    func setTextTitleStyle(size: CGFloat) -> some View {
        modifier(setTextMediumWhiteStyle(size: size))
    }
}
