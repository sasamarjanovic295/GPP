//
//  BusStopDetailView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI
import MapKit

struct Route: Identifiable {
    var id = UUID().uuidString
    let number: String
    let destination: String
    let time: Date
}

struct BusStopDetailView: View {
    
    var busStop:BusStop
    var routesForBusStop: [Route] = [Route(number: "1", destination: "Kampus",
                                           time: Date(timeIntervalSinceNow: TimeInterval(3630))),
                                     Route(number: "2", destination: "Kampus",
                                           time: Date(timeIntervalSinceNow: TimeInterval(3630))),
                                     Route(number: "3", destination: "Kampus",
                                           time: Date(timeIntervalSinceNow: TimeInterval(300))),
                                     Route(number: "4", destination: "Kampus",
                                           time: Date(timeIntervalSinceNow: TimeInterval(3330))),
                                     Route(number: "5", destination: "Kampus",
                                           time: Date(timeIntervalSinceNow: TimeInterval(3230)))]
    
    var body: some View {
        
        VStack{
        
            VStack{
                    
                Text(busStop.name)
                    .font(.title2)
                    .padding()
            
                HStack{
                    Text("LINIJE KOJE PROLAZE")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                    Spacer()
                }
                
                HStack{
                    Image(systemName: "bus.fill")
                        .foregroundColor(.blue)
                        .padding(EdgeInsets(top: 1,leading: 0, bottom: 1, trailing: 8))
                    ForEach(routesForBusStop) { route in
                        if route.number != routesForBusStop.last?.number {
                            Text(route.number + ",")
                                .foregroundColor(.black.opacity(0.7))
                        }
                        else{
                            Text(route.number)
                                .foregroundColor(.black.opacity(0.7))
                        }
                    }
                    Spacer()
                }
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                
                HStack{
                    Text("LINIJE")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                    Text("ODREDISTE")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                    Spacer()
                    Text("DOLAZAK")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                }
                
            }
            .padding(.horizontal)
        
            List(routesForBusStop) { route in
                
                BusArrivalView(route: route)
            }
            .listStyle(.plain)
            
            Spacer()
        }
    }
}

struct BusStopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopDetailView(busStop:BusStop(name: "Centralno groblje",
        coordinate: CLLocationCoordinate2D(latitude: 45.53174983310974, longitude: 18.671850304788737)))
    }
}
