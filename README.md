# ☀️ Today's Weather
<img src="https://github.com/user-attachments/assets/8e3fa3f5-6168-45c8-8485-4948867a8b3d" width="100" height="100">


### OpenWeatherAPI를 통한 날씨 검색 어플
- iOS 1인 개발
- 최소 버전 iOS 16.0
- Light, 세로 버전
- 개발 기간 2024.09.27 ~ 2024.09.29 (3일)


## 🌤️ 주요 기능
- 사용자가 선택한 도시에 대한 날씨 조회 기능
    - 선택한 도시의 현재 날씨
    - 오늘 포함 2일간의 날씨 정보 제공 (3시간 간격)
    - 오늘 포함 5일간의 날씨 정보 제공 (최대 최소 기온)
    - 습도, 구름, 바람 속도 제공
    - 선택한 도시의 지도상 위치 제공
- 원하는 도시 검색 및 조회 기능



## ⚒️ 사용 기술 및 라이브러리 
 `MVI`
 `Alamofire`
 `Combine`
 `SwiftUI`
 `Singleton`
 `DTO`
 `SPM`
 `UIViewControllerRepresentable`
 `Codable`



## ⚒️ 기술 적용
- **MVI Pattern**을 적용하여 단방향 데이터 흐름을 통해 Intent로 사용자 입력을 처리, State를 통해 view 업데이트
- **UIViewControllerRepresentable**을 통해 SwiftUI와 UIKit을 혼합적으로 사용
- **CustomModifier**를 통해 코드의 재사용성과 일관성을 높임
- **taskModifier**를 사용하여 뷰의 초기화 시점에 비동기 작업을 자동으로 실행하도록 구현
- **CustomView**를 통해 뷰의 재사용성 강화
- **@StateObject**로 viewModel을 선언하여 view의 생명주기 동안 뷰모델의 상태를 지속적으로 관리
- **AnyCancellable**을 구독을 저장하고 관리하여 비동기 작업의 메모리 관리
- **NWPathMonitor**를 통해 네트워크 상태 변화를 감지
- **@MainActor**를 통해 UI 작업이 메인스레드에서 안전하게 실행되도록 보장
- **debounce**를 통해 불필요한 요청을 줄임
- **propertyWrapper**를 통해 UserDefaults 값을 저장 및 접근할 수 있도록 설계

## 📷 스크린샷


|전체 구성|도시 검색|네트워크 상태 관리|API 통신 관리|
|:---:|:---:|:---:|:---:|
|<img src="https://github.com/user-attachments/assets/b0a7a45f-9df1-4ea7-8d72-ba3c179ab278" width="200" height="390"/>|<img src="https://github.com/user-attachments/assets/ccb572e1-2877-448d-9475-89647d08f7e8" width="200" height="390"/>|<img src="https://github.com/user-attachments/assets/53703efb-432d-488f-a774-c139517dfda6" width="200" height="390"/>|<img src="https://github.com/user-attachments/assets/24ae077c-35a2-4471-ab88-577ad7a1b8c7" width="200" height="390"/>|


## 💥 트러블슈팅

### DTO를 이용해 API 통신 후 받은 결과값에 대한 데이터 가공
<details>
<summary>켈빈(Kelvin) 온도 단위에서 섭씨(Celsius) 온도로 데이터를 가공하여 viewModel에서 별도의 가공을 하지 않도록 설계</summary>

```Swift
struct TodayWeatherResponseDTO: ResponseDTOType {
    var coord: Coordinates
    var weather: [Weather]
    var main: MainInfo
    var wind: Wind
    var clouds: Cloud
}

extension TodayWeatherResponseDTO {
    func toDomain() -> TodayWeatherModel {
        
        let celsiusTemp = Int(main.temp - 273.15)
        let celsiusMin = Int(main.temp_min - 273.15)
        let celsiusMax = Int(main.temp_max - 273.15)
        
        return .init(coord: coord, city: "", temp: celsiusTemp, temp_min: celsiusMin, temp_max: celsiusMax, description: weather.first?.description ?? "", windSpeed: wind.speed, humidity: main.humidity, clouds: clouds.all)
    }
}
```
</details>


### NWPathMonitor를 통해 네트워크의 상태 변화를 감지하여 이에 따른 UI 업데이트
<details>
<summary>네트워크 상태를 지속적으로 관찰하고 해당 값을 @Published를 통해 viewModel과 공유하여 view의 state를 관리</summary>

```Swift
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
```
</details>



### JSON 데이터를 비동기 방식(async/await)으로 로드하여 초기 데이터 처리 시 대용량 데이터로 인한 UI 업데이트 속도 저하 해결 및 성능 개선
<details>
<summary>대량의 JSONData을 parsing 할 때 검색 뷰에서 UI 업데이트 시 많은 시간 소요됐던 문제 해결</summary>

```Swift
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


```
</details>
