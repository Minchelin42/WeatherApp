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
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.preferredConfiguration = MKHybridMapConfiguration()
        mapView.isUserInteractionEnabled = false
        mapView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon), span: MKCoordinateSpan(latitudeDelta: 7.0,
                                                                                                                                                         longitudeDelta: 7.0)), animated: true)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat,
                                                       longitude: coordinate.lon)

        mapView.addAnnotation(annotation)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        DispatchQueue.main.async {
            
            uiView.removeAnnotations(uiView.annotations)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon)
            uiView.addAnnotation(annotation)
            
            uiView.setRegion(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: coordinate.lat, longitude: coordinate.lon), span: MKCoordinateSpan(latitudeDelta: 7.0,
                                                                                                                                                                 longitudeDelta: 7.0)), animated: true)
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
    }
}

