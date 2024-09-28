//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation
import Combine

struct WeatherState {
    var nowWeather: TodayWeatherModel? = nil
    var threeHourWeather: [WeatherForecastModel] = []
    var fiveDayWeather: [minMaxWeatherInfo] = []
    var searchPresent: Bool = false
}

struct minMaxWeatherInfo {
    var temp_min: Int //기온
    var temp_max: Int //기온
    var weatherIcon: String //날씨 이미지
    var day: String //요일
}

enum WeatherIntent {
    case loadCityWeather
    case searchCity
}

@MainActor
final class WeatherViewModel: ObservableObject {
    
    @Published var state = WeatherState()
    @Published var nowCity: City

    private var cancellables = Set<AnyCancellable>()
    
    init(initCity: City = City(id: 1839726, name: "Asan", country: "KR", coord: Coordinates(lon: 127.004173, lat: 36.783611))) {
        self.nowCity = initCity
        self.dispatch(intent: .loadCityWeather)
    }
    
    func dispatch(intent: WeatherIntent) {
        switch intent {
        case .loadCityWeather:
            print("loadCityWeather")
            loadCityWeather()
        case .searchCity:
            print("searchCity")
            presentSearchView()
        }
    }
    
    func loadCityWeather2() {
        NetworkManager.shared.weatherAPICall(model: TodayWeatherResponseDTO.self, router: WeatherRouter.current(city: self.nowCity))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print("Error loading weather: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                self.state.nowWeather = weather.toDomain()
            })
            .store(in: &cancellables)
    }
    
    func loadCityWeather() {
        NetworkManager.shared.weatherAPICall(model: WeatherForecastResponseDTO.self, router: WeatherRouter.day2hour3(city: self.nowCity))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print("Error loading weather: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                let weatherForecast = weather.toDomain()
                let today = weatherForecast.first?.date.prefix(10) //YYYY-MM-DD
                var todayIndex = 0
                var day2WeatherForecast = []
                var day5WeatherForecast = []
                
                for index in 0..<weatherForecast.count {
                    if !weatherForecast[index].date.contains(today) {
                        todayIndex = index
                        print("확인 중\(weatherForecast[index].date)")
                    }
                }
                
                //여기서 2일 3시간 간격이랑 5일 최고 최저 계산
                
                
                
                
            })
            .store(in: &cancellables)
    }
    
    func presentSearchView() {
        state.searchPresent = true
    }
}
