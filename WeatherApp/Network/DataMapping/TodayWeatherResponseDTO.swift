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
    var base: String
    var main: MainInfo
    var visibility: Int
    var wind: Wind
    var clouds: Cloud
    var name: String
}

struct Weather: Codable, Equatable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct MainInfo: Codable, Equatable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    var sea_level: Int
    var grnd_level: Int
}

struct Wind: Codable, Equatable {
    var speed: Double
    var deg: Int
    var gust: Double
}

struct Cloud: Codable, Equatable {
    var all: Int
}


extension TodayWeatherResponseDTO {
    func toDomain() -> TodayWeatherModel {
        
        let celsiusTemp = Int(main.temp - 273.15)
        let celsiusMin = Int(main.temp_min - 273.15)
        let celsiusMax = Int(main.temp_max - 273.15)
        
        return .init(coord: coord, city: name, temp: celsiusTemp, temp_min: celsiusMin, temp_max: celsiusMax, description: weather.first?.description ?? "", windSpeed: wind.speed, humidity: main.humidity, clouds: clouds.all)
    }
}

