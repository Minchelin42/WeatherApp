//
//  FutureWeatherResponseDTO.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation

struct WeatherForecastResponseDTO: ResponseDTOType {
    var list: [WeatherForecast]
}

struct WeatherForecast: Codable, Equatable {
    var main: MainInfo //main - temp
    var weather: [Weather] //weather - icon
    var dt_txt: String //date
}

extension WeatherForecastResponseDTO {
    func toDomain() -> [WeatherForecastModel] {

        var result: [WeatherForecastModel] = []
        for weather in self.list {
            
            let celsiusTemp = Int(weather.main.temp - 273.15)
            var weatherIcon = weather.weather.first?.icon ?? ""

            weatherIcon = weatherIcon.replacingOccurrences(of: "n", with: "d")
            
            result.append(WeatherForecastModel(temp: celsiusTemp, weatherIcon: weatherIcon, date: weather.dt_txt))
        }
        
        return result
    }
}

