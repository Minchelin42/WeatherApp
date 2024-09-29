//
//  LoadingView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        VStack {
            Spacer()
            ProgressView()
            .scaleEffect(1.5, anchor: .center)
            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            Spacer()
        }
    }

}
