//
//  MainResponseDTO.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation

struct TodayWeatherResponseDTO: ResponseDTOType {
    var coord: Coordinates
    var weather: [Weather]
    var main: MainInfo
    var wind: Wind
    var clouds: Cloud
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainInfo: Codable {
    var temp: Double
    var temp_min: Double
    var temp_max: Double
    var humidity: Int
}

struct Wind: Codable {
    var speed: Double
}

struct Cloud: Codable {
    var all: Int
}


extension TodayWeatherResponseDTO {
    func toDomain() -> TodayWeatherModel {
        
        let celsiusTemp = Int(main.temp - 273.15)
        let celsiusMin = Int(main.temp_min - 273.15)
        let celsiusMax = Int(main.temp_max - 273.15)
        
        return .init(coord: coord, city: "", temp: celsiusTemp, temp_min: celsiusMin, temp_max: celsiusMax, description: weather.first?.description ?? "", windSpeed: wind.speed, humidity: main.humidity, clouds: clouds.all)
    }
}

