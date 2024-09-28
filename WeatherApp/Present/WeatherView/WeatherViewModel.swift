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

struct minMaxWeatherInfo: Hashable {
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
        self.nowCitySetting()
    }
    
    func dispatch(intent: WeatherIntent) {
        switch intent {
        case .loadCityWeather:
            print("loadCityWeather")
            loadCityWeather()
            loadDaysWeather()
        case .searchCity:
            print("searchCity")
            presentSearchView()
        }
    }
    
    private func nowCitySetting() {
        $nowCity
              .sink { [weak self] _ in
                  guard let self = self else { return }
                  self.dispatch(intent: .loadCityWeather)
              }
              .store(in: &cancellables)
    }
    
    func loadCityWeather() {
        NetworkManager.shared.weatherAPICall(model: TodayWeatherResponseDTO.self, router: WeatherRouter.current(city: self.nowCity))
            .receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading weather: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.state.nowWeather = weather.toDomain()
                }
            })
            .store(in: &cancellables)
    }
    
    func loadDaysWeather() {
        NetworkManager.shared.weatherAPICall(model: WeatherForecastResponseDTO.self, router: WeatherRouter.day2hour3(city: self.nowCity))
            .receive(on: DispatchQueue.global())
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error loading weather: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] weather in
                guard let self = self else { return }
                
                let weatherForecast = weather.toDomain()
                saveDaysWeather(with: weatherForecast)
                
            })
            .store(in: &cancellables)
    }
    
    private func saveDaysWeather(with weatherForecast: [WeatherForecastModel]) {
        var today = weatherForecast.first?.date ?? ""
        today = String(today.prefix(10)) //YYYY-MM-DD
        var todayIndex = 0
        var day2WeatherForecast: [WeatherForecastModel] = []
        var day5WeatherForecast: [WeatherForecastModel] = []
        
        //오늘 날씨까지만 저장
        for index in 0..<weatherForecast.count {
            if !weatherForecast[index].date.contains(today) {
                todayIndex = index
                break
            } else {
                day2WeatherForecast.append(weatherForecast[index])
                day5WeatherForecast.append(weatherForecast[index])
            }
        }
        
        //오늘 이후 1일간 날씨, 4일간 날씨 저장
        for index in todayIndex..<todayIndex + 32 {
            if index < todayIndex + 8 {
                day2WeatherForecast.append(weatherForecast[index])
            }
            day5WeatherForecast.append(weatherForecast[index])
        }
        
        for index in 0..<day2WeatherForecast.count {
            day2WeatherForecast[index].date = convertDateFormat(input: day2WeatherForecast[index].date)
        }
        
        DispatchQueue.main.async {
            self.state.threeHourWeather = day2WeatherForecast
        }
        
        var minMaxTemperatures: [minMaxWeatherInfo] = []
       
        //오늘의 최고 최저
        let todayOfMinMax = getMinMaxTemperature(weatherArr: day5WeatherForecast, startIndex: 0, endIndex: todayIndex)
        minMaxTemperatures.append(todayOfMinMax)

        //이후 4일간의 최고 최저
        for i in stride(from: todayIndex, to: day5WeatherForecast.count, by: 8) {
            let end = min(i + 8, day5WeatherForecast.count) // 범위 초과 방지

            let dayOfMinMax = getMinMaxTemperature(weatherArr: day5WeatherForecast, startIndex: i, endIndex: end)
            minMaxTemperatures.append(dayOfMinMax)
        }
        
        for index in 0..<minMaxTemperatures.count {
            if index == 0 {
                minMaxTemperatures[index].day = "오늘"
            } else {
                minMaxTemperatures[index].day = convertDateFormatToDay(input: minMaxTemperatures[index].day)
            }
        }
        
        DispatchQueue.main.async {
            self.state.fiveDayWeather = minMaxTemperatures
        }
    }
    
    private func getMinMaxTemperature(weatherArr: [WeatherForecastModel], startIndex: Int, endIndex: Int) -> minMaxWeatherInfo {
        let subArray = Array(weatherArr[startIndex..<endIndex]) // 5개씩 서브 배열 생성
        
        // 각 서브 배열의 최대 및 최소값 구하기
        if let minTemp = subArray.map({ $0.temp }).min(),
           let maxTemp = subArray.map({ $0.temp }).max() {
            return minMaxWeatherInfo(temp_min: minTemp, temp_max: maxTemp, weatherIcon: weatherArr[startIndex].weatherIcon, day: weatherArr[startIndex].date)
        } else {
            return minMaxWeatherInfo(temp_min: 0, temp_max: 0, weatherIcon: "", day: "")
        }
    }
    
    func convertDateFormat(input: String) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        guard let date = dateFormatter.date(from: input) else { return "" }

        dateFormatter.dateFormat = "a h"
        dateFormatter.locale = Locale(identifier: "ko_KR")
 
        return dateFormatter.string(from: date) ?? ""
    }
    
    func convertDateFormatToDay(input: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let date = dateFormatter.date(from: input) else { return "" }

        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "ko_KR")

        return dateFormatter.string(from: date) ?? ""
    }
    
    func presentSearchView() {
        state.searchPresent = true
    }
}