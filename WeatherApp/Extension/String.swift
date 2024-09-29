//
//  String.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import Foundation

extension String {
    // yyyy-MM-dd HH:mm:ss -> (오전/오후) 시
    func toFormattedTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let date = dateFormatter.date(from: self) else { return "" }

        dateFormatter.dateFormat = "a h"
        dateFormatter.locale = Locale(identifier: "ko_KR")

        return "\(dateFormatter.string(from: date))시"
    }

    // yyyy-MM-dd HH:mm:ss -> 요일
    func toFormattedDay() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"

        guard let date = dateFormatter.date(from: self) else { return "" }

        dateFormatter.dateFormat = "E"
        dateFormatter.locale = Locale(identifier: "ko_KR")

        return dateFormatter.string(from: date)
    }
}
