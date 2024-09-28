//
//  TodayWeatherModel.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation

struct TodayWeatherModel {
    var coord: Coordinates
    var city: String // name
    var temp: Int
    var temp_min: Int
    var temp_max: Int
    var description: String
    var windSpeed: Double  //wind - speed
    var humidity: Int // main - humidity
    var clouds: Int //clouds - all
}
