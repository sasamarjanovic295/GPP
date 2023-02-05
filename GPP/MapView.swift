//
//  MapView.swift
//  GPP
//
//  Created by Saša Marjanović on 03.02.2023..
//

import SwiftUI
import MapKit

struct OsijekMapView: View {
    
    @EnvironmentObject var busStopData: BusStopData
    
    private let osijekLocation = CLLocation(latitude: 45.5550, longitude: 18.6955)
    
    var osijekRegion: MKCoordinateRegion{
        return MKCoordinateRegion( center: osijekLocation.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
    }
    
    var body: some View {
        NavigationView{
            VStack{
                Map(coordinateRegion: Binding.constant(osijekRegion), annotationItems: busStopData.busStops){ busStop in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(
                            latitude: busStop.latitude, longitude: busStop.longitude)){
                        NavigationLink(destination: BusStopDetailView(busStop: Binding.constant(busStop)) , label:{
                            BusStopAnnotationView()
                        })
                    }
                }
            }
            .navigationBarHidden(true)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.horizontal)
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        OsijekMapView()
    }
}
