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
    var searchPresent: Bool = false
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
    
    func loadCityWeather() {
        NetworkManager.shared.weatherAPICall(model: TodayWeatherResponseDTO.self, router: WeatherRouter.current(city: self.nowCity))
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
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
    
    func presentSearchView() {
        state.searchPresent = true
    }
}
