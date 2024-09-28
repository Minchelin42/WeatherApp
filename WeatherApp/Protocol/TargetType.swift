//
//  TargetType.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation
import Alamofire

protocol TargetType: URLRequestConvertible {
    
    var baseURL: String { get }
    var method: HTTPMethod { get }
    var path: String { get }
    var header: [String : String] { get }
    var parameters: String? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
    
}

extension TargetType {
    func asURLRequest() throws -> URLRequest {
        var url = try baseURL.asURL()
        url.append(queryItems: queryItems ?? [])
        var urlRequest = try URLRequest(url: url.appendingPathComponent(path), method: method)
        urlRequest.allHTTPHeaderFields = header
        urlRequest.httpBody = parameters?.data(using: .utf8)
        urlRequest.httpBody = body
        return urlRequest
    }
}
