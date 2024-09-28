//
//  NoResultView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import SwiftUI

struct NoResultView: View {
    
    var body: some View {
        VStack {
            Spacer()
            Text("검색 결과가 없습니다").setTextBigStyle(size: 20).padding(.bottom, 4)
            Text("검색어를 다시 한번 더 확인해주세요").setTextTitleStyle(size: 14)
            Spacer()
        }
    }
}

#Preview {
    NoResultView()
}
