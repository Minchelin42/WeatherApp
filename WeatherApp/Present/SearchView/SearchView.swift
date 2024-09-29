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
                VStack(spacing: 16) {
                    WeatherSearchBar(text: $viewModel.query, tfInactive: false)
                 
                    if !viewModel.state.cityList.isEmpty {
                        ScrollView() {
                            LazyVStack {
                                ForEach(viewModel.state.cityList, id: \.id) { city in
                                    CityCell(city: city)
                                        .onTapGesture {
                                            weatherViewModel.nowCity = city
                                            dismiss()
                                        }
                                        .onAppear {
                                            if city == viewModel.state.cityList.last && viewModel.query.isEmpty {
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
                .padding(.vertical, Padding.weatherVerticalPadding)
            }

    }
}


struct CityCell: View {
    
    var city: City
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(city.name).setTextLargeTitleStyle(size: 16)
            Text(city.country).setTextLargeTitleStyle(size: 12)
            SeperateLine()
        }
        .contentShape(Rectangle())
    }
}
