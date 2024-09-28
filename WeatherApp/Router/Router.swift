//
//  Router.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import SwiftUI

public enum NextView: Hashable {
    case weatherView
    case searchView
}

struct FeatureView: View {
    let type: NextView
    
    var body: some View {
        switch type {
        case .weatherView:
            WeatherView()
        case .searchView:
            SearchView()
        }
    }
}

public final class Router: ObservableObject {
    @Published public var route = NavigationPath()
    public init() { }
    
    @MainActor
    public func push<T: Hashable>(view: T) {
        route.append(view)
    }
    
    @MainActor
    public func pop() {
        route.removeLast()
    }
    
    @MainActor
    public func pop(depth: Int) {
        route.removeLast(depth)
    }
    
    @MainActor
    public func popToRoot() {
        route = NavigationPath()
    }
    
    @MainActor
    public func switchView<T: Hashable>(view: T) {
        guard !route.isEmpty else { return }
        var tempRoute = route
        tempRoute.removeLast()
        tempRoute.append(view)
        route = tempRoute
    }
}
