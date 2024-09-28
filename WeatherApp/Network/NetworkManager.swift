//
//  JsonParsing.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation
import Combine
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()
    private init() { }
    
    func weatherAPICall<T: Decodable>(model: T.Type, router: TargetType) -> AnyPublisher<T, Error> {
        do {
            let urlRequest = try router.asURLRequest()
            
            return AF.request(urlRequest)
                .validate(statusCode: 200..<420)
                .publishDecodable(type: model.self)
                .value() // Combine의 value 메서드를 통해 성공 시의 결과값만 추출
                .mapError { error -> Error in
                    if let afError = error.asAFError {
                        switch afError {
                        case .responseValidationFailed(let reason):
                            print("Response validation failed: \(reason)")
                        case .sessionTaskFailed(let sessionError):
                            print("Session task failed: \(sessionError)")
                        default:
                            print("Error: \(afError.localizedDescription)")
                        }
                    }
                    return error
                }
                .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
