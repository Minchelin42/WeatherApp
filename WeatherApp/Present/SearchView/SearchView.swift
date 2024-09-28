//
//  SearchView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/27/24.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject private var viewModel = SearchViewModel()
    @ObservedObject var weatherViewModel: WeatherViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
            ZStack {
                Color.mainColor
                    .ignoresSafeArea()
                VStack {
                    Spacer().frame(height: 24)
                    WeatherSearchBar(text: $viewModel.query, tfInactive: false)
                    Spacer().frame(height: 16)
                    if !viewModel.state.cityList.isEmpty {
                        ScrollView() {
                            LazyVStack {
                                ForEach(viewModel.state.cityList, id: \.id) { city in
                                    CityCell(city: city)
                                        .onTapGesture {
                                            print("지금 클릭한 도시 \(city.name)")
                                            weatherViewModel.nowCity = city
                                            dismiss()
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
                    } else {
                        NoResultView()
                    }
                }
                .padding(.horizontal, Padding.weatherHorizontalPadding)
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
