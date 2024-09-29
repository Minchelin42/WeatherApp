//
//  UserInfo.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import Foundation

struct UserInfo {
    @UserDefaultManager(key: UDKey.id.rawValue, defaultValue: 1839726)
    static var id: Int
    @UserDefaultManager(key: UDKey.city.rawValue, defaultValue: "Asan")
    static var city: String
    @UserDefaultManager(key: UDKey.country.rawValue, defaultValue: "KR")
    static var country: String
    @UserDefaultManager(key: UDKey.lon.rawValue, defaultValue: 127.004713)
    static var lon: Double
    @UserDefaultManager(key: UDKey.lat.rawValue, defaultValue: 36.783611)
    static var lat: Double
}

enum UDKey: String {
    case id = "id"
    case city = "city"
    case country = "KR"
    case lon = "lon"
    case lat = "lat"
}
