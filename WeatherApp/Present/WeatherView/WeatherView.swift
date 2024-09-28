//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    var body: some View {

            ZStack {
                Color.mainColor
                    .ignoresSafeArea()
                
                ScrollView() {
                    VStack(spacing: 16) {
                        WeatherSearchBar(tfInactive: true)
                            .contentShape(Rectangle())
                            .sheet(isPresented: $viewModel.state.searchPresent, content: {
                                SearchView(weatherViewModel: viewModel)
                            })
                            .onTapGesture {
                                print("searchBar Click")
                                viewModel.dispatch(intent: .searchCity)
                            }

                        if let weather = viewModel.state.nowWeather {
                            WeatherInfoView(weather: weather)
                        }
                        Day2WeatherView(day2Weather: viewModel.state.threeHourWeather)
                        Day5WeatherView(day5Weather: viewModel.state.fiveDayWeather)
                        WeatherMapView()
                        if let weather = viewModel.state.nowWeather {
                            WeatherEtcView(weather: weather)
                        }
                    }
                    .padding(.horizontal, Padding.weatherHorizontalPadding)
                    .frame(maxHeight: .infinity)
                }
                .scrollIndicators(.hidden)
            }
            .task {
                viewModel.dispatch(intent: .loadCityWeather)
            }
        
    }
}

