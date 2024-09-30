//
//  City.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import SwiftUI

struct City: Codable, Hashable, Equatable {
    
    var id: Int
    var name: String
    var country: String
    var coord: Coordinates

}

struct Coordinates: Codable, Hashable, Equatable {
    var lon: Double
    var lat: Double
}

