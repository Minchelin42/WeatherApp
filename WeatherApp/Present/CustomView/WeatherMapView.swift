//
//  weatherMapView.swift
//  WeatherApp
//
//  Created by 민지은 on 9/27/24.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    
    var coordinate: Coordinates
    
    /// 사용할 UIView를 생성하고, 초기화하는 메서드
    func makeUIView(context: Context) -> MKMapView {
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon), span: MKCoordinateSpan(latitudeDelta: 5.0,
                                                                                                                                                         longitudeDelta: 5.0)), animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat,
                                                       longitude: coordinate.lon)

        mapView.addAnnotation(annotation)
        return mapView
    }
    
    /// UIView의 뷰 업데이트가 필요할 때 호출되는 메서드
    func updateUIView(_ uiView: MKMapView, context: Context) {
        print("지금 좌표: \(coordinate.lon) \(coordinate.lat)")
        DispatchQueue.main.async {
            uiView.removeAnnotations(uiView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
            uiView.addAnnotation(annotation)
            
            // 지도 중심 및 영역 업데이트
            uiView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon), span: MKCoordinateSpan(latitudeDelta: 5.0,
                                                                                                                                                                 longitudeDelta: 5.0)), animated: true)
        }
    }
}

struct WeatherMapView: View {
    
    var weather: TodayWeatherModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer().frame(height: Padding.weatherHorizontalPadding)
            HStack {
                Text("위치").setTextTitleStyle(size: Fonts.weatherCellSub)
                Spacer()
            }
            Spacer()

            MapViewRepresentable(coordinate: weather.coord)
                .ignoresSafeArea()
                .frame(maxWidth: .infinity)
                .frame(height: 320)
            
            Spacer().frame(height: Padding.weatherHorizontalPadding)
        }
        .padding(.horizontal, Padding.weatherHorizontalPadding)
        .setBackgroundStyle(color: Color.mainColor, cornerRadius: 14, height: 380)
        .onAppear {
            print(weather.coord)
        }
    }
}

