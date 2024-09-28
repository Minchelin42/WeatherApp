//
//  TodayWeatherModel.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation

struct TodayWeatherModel {
    let coord: Coordinates
    let city: String // name
    let temp: Int
    let temp_min: Int
    let temp_max: Int
    let description: String
    let windSpeed: Double  //wind - speed
    let humidity: Int // main - humidity
    let clouds: Int //clouds - all
}
