//
//  NetworkMonitor.swift
//  WeatherApp
//
//  Created by 민지은 on 9/29/24.
//

import SwiftUI
import Combine
import Network

class NetworkMonitor {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: "Monitor")
    
    @Published var isConnected = false
    
    init() {
        networkMonitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
            
        }
        networkMonitor.start(queue: workerQueue)
    }
}
