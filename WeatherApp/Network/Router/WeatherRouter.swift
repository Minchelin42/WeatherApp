//
//  WeatherRouter.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation
import Alamofire

enum WeatherRouter {
    case current(city: City)
    case day2hour3(city: City)
    case day5MaxMin(city: City)
}

extension WeatherRouter: TargetType {
    
    var baseURL: String {
        return "https://api.openweathermap.org/data/2.5/"
    }

    var method: Alamofire.HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .current:
            return "weather"
        case .day2hour3:
            return "forecast"
        case .day5MaxMin:
            return "forecast"
        }
    }
    
    var header: [String : String] {
        return [:]
    }
    
    var parameters: String? {
       return nil
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .current(let city), .day2hour3(let city), .day5MaxMin(let city):
            return [URLQueryItem(name: "lat", value: String(city.coord.lat)), URLQueryItem(name: "lon", value: String(city.coord.lon)), URLQueryItem(name: "appid", value: ""),
                    URLQueryItem(name: "lang", value: "kr")]
        }
    }
    
    var body: Data? {
        return nil
    }
    
}