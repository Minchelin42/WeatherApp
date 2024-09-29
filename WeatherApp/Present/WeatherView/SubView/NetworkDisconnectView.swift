//
//  NetworkDisconnectView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import SwiftUI

struct NetworkDisconnectView: View {
    
    var body: some View {
        
        ZStack {
            Color.mainColor
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                AppImage.networkError
                    .resizable()
                    .foregroundColor(.whiteColor)
                    .frame(width: 80, height: 80)
                    .aspectRatio(contentMode: .fit)
                Spacer().frame(height: 20)
                Text("인터넷 연결 상태를 확인해주세요").setTextLargeTitleStyle(size: 14)
                Spacer().frame(height: 4)
                Text("네트워크 연결이 안정된 후 서비스를 이용하실 수 있습니다").setTextTitleStyle(size: 12)
            }

        }

    }
}


