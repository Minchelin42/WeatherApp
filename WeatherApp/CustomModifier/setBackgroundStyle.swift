//
//  setBackgroundStyle.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

private struct setBackgroundRoundStyle: ViewModifier {
    
    let color: Color
    let height: CGFloat
    let cornerRadius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: height)
            .background(color)
            .cornerRadius(cornerRadius)
    }
    
}


extension View {
    func setBackgroundStyle(color: Color, cornerRadius: CGFloat, height: CGFloat) -> some View {
        modifier(setBackgroundRoundStyle(color: color, height: height, cornerRadius: cornerRadius))
    }
}
