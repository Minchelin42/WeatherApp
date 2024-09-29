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
        if viewModel.state.networkConnect {
            ZStack {
                Color.mainColor
                    .ignoresSafeArea()
                if viewModel.state.isLoading {
                    LoadingView()
                } else {
                    ScrollView() {
                        VStack(spacing: 16) {
                            WeatherSearchBar(tfInactive: true)
                                .contentShape(Rectangle())
                                .sheet(isPresented: $viewModel.state.searchPresent, content: {
                                    SearchView(weatherViewModel: viewModel)
                                })
                                .onTapGesture {
                                    viewModel.dispatch(intent: .searchCity)
                                }
                            
                            WeatherInfoView(weather: viewModel.state.nowWeather)
                            Day2WeatherView(day2Weather: viewModel.state.threeHourWeather)
                            Day5WeatherView(day5Weather: viewModel.state.fiveDayWeather)
                            WeatherMapView(weather: viewModel.state.nowWeather)
                            WeatherEtcView(weather: viewModel.state.nowWeather)
                            
                        }
                        .padding(.horizontal, Padding.weatherHorizontalPadding)
                        .padding(.vertical, Padding.weatherVerticalPadding)
                        .frame(maxHeight: .infinity)
                    }
                    .scrollIndicators(.hidden)
                }
            }
            .task {
                viewModel.dispatch(intent: .loadCityWeather)
            }
        } else {
            NetworkDisconnectView()
        }
        
    }
}



