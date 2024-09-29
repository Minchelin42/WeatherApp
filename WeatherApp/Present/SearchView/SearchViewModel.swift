//
//  SearchViewModel.swift
//  WeatherApp
//
//  Created by 민지은 on 9/28/24.
//

import Foundation
import Combine

struct SearchState {
    var cityList: [City] = []
}

enum SearchIntent {
    case loadInitCity
    case loadMore
    case searchCity(query: String)
}

@MainActor
final class SearchViewModel: ObservableObject {
    
    @Published var state = SearchState()
    @Published var selectCity: City?
    @Published var query: String = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    var allCityList: [City] = []
    var loadCityList: [City] = []
    
    var currPage = 0
    var defaultCnt = 30

    init() {
        dispatch(intent: .loadInitCity)
        bindSearchQuery()
    }
    
    func dispatch(intent: SearchIntent) {
        switch intent {
        case .loadInitCity:
            loadInitCities()
        case .loadMore:
            loadMoreCities()
        case .searchCity(let query):
            filterCities(with: query)
        }
    }
    
    
    private func loadInitCities() {
        
        Task {
            let cities: [City] = try await loadJsonData("citylist")

            self.loadCityList = Array(cities.prefix(self.defaultCnt))
            self.state.cityList = self.loadCityList
            self.allCityList = cities

            let firstPageOfCities = Array(self.allCityList.dropFirst(self.defaultCnt))
            
            self.loadCityList.append(contentsOf: firstPageOfCities)
            self.allCityList = self.loadCityList
        }

    }
    
    private func loadJsonData<T: Decodable>(_ jsonFile: String) async throws -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: jsonFile, withExtension: "json") else {
            fatalError("\(jsonFile).json Couldn't find in main bundle")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("\(jsonFile).json Couldn't load in main bundle\nError:\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        } catch {
            fatalError("\(jsonFile) parsing Failed\nError:\(error)")
        }

    }

    private func loadMoreCities() {
        let startIndex = currPage * defaultCnt
        let endIndex = min(startIndex + defaultCnt, loadCityList.count)
        
        if startIndex < endIndex {
            let moreCityList = Array(loadCityList[startIndex..<endIndex])
            state.cityList.append(contentsOf: moreCityList)
            
            currPage += 1
        }
    }
    
    private func filterCities(with query: String) {
        if query.isEmpty {
            state.cityList = loadCityList
        } else {
            state.cityList = loadCityList.filter { city in
                city.name.lowercased().contains(query.lowercased())
            }
        }
    }
    
    private func bindSearchQuery() {
        $query
              .debounce(for: .seconds(0.3), scheduler: RunLoop.main)
              .removeDuplicates()
              .sink { [weak self] newQuery in
                  guard let self = self else { return }
                  self.dispatch(intent: .searchCity(query: newQuery))
              }
              .store(in: &cancellables)
    }

}
