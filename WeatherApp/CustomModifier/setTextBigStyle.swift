//
//  setTextBigStyle.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

private struct setTextSemiBoldWhiteStyle: ViewModifier {
    
    let size: CGFloat
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: size))
            .fontWeight(.semibold)
            .foregroundColor(Color.whiteFont)
    }
    
}


extension View {
    func setTextBigStyle(size: CGFloat) -> some View {
        modifier(setTextSemiBoldWhiteStyle(size: size))
    }
}
