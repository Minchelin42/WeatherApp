//
//  FutureWeatherModel.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import SwiftUI

struct WeatherForecastModel: Hashable {
    var temp: Int //기온
    var weatherIcon: String //날씨 이미지
    var date: String //날짜
}
