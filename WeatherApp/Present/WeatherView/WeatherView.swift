//
//  WeatherView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/26/24.
//

import SwiftUI

struct WeatherView: View {
    
    @StateObject private var viewModel = WeatherViewModel()
    @State private var networkMonitor = NetworkMonitor()
    
    var body: some View {
            
        if networkMonitor.isConnected {
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
                                    print("searchBar Click")
                                    viewModel.dispatch(intent: .searchCity)
                                }
                            
                            WeatherInfoView(weather: viewModel.state.nowWeather)
                            Day2WeatherView(day2Weather: viewModel.state.threeHourWeather)
                            Day5WeatherView(day5Weather: viewModel.state.fiveDayWeather)
                            WeatherMapView(weather: viewModel.state.nowWeather)
                            WeatherEtcView(weather: viewModel.state.nowWeather)
                            
                        }
                        .padding(.horizontal, Padding.weatherHorizontalPadding)
                        .padding(.vertical, Padding.weatherHorizontalPadding)
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

