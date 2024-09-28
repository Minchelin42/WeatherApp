//
//  ResponseDTOType.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation

protocol ResponseDTOType: Decodable {
    associatedtype DomainModel
    func toDomain() -> DomainModel
}
