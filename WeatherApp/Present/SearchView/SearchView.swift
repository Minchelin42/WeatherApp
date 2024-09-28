//
//  SearchView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/27/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.router.route) {
            ZStack {
                Color.mainColor
                    .ignoresSafeArea()
                VStack {
                    WeatherSearchBar(text: $viewModel.query)
                    Spacer().frame(height: 16)
                    ScrollView() {
                        LazyVStack {
                            ForEach(viewModel.state.cityList, id: \.id) { city in
                                CityCell(city: city)
                                    .onTapGesture {
                                        viewModel.dispatch(intent: .selectCity(city: city))
                                    }
                                    .onAppear {
                                        if city == viewModel.state.cityList.last {
                                            viewModel.dispatch(intent: .loadMore)
                                        }
                                    }
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal, Padding.weatherHorizontalPadding)
            }
        }

    }
}


struct CityCell: View {
    
    var city: City
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(city.name).setTextBigStyle(size: 16)
            Text(city.country).setTextBigStyle(size: 12)
            seperateLine()
        }
        .contentShape(Rectangle())
    }
}

//#Preview {
//    SearchView()
//}
