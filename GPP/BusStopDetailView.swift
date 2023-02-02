//
//  BusStopDetailView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI
import MapKit

struct BusStopDetailView: View {
    
    var busStop:BusStop
    var routesForBusStop: [Route] = []
    
    
    var body: some View {
        
        VStack{
        
            VStack{
        
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
            .padding(EdgeInsets(top: 18, leading: 18, bottom: 0, trailing: 18))
            
//            List(routesForBusStop.sorted(by: { (route1, route2) in
//                route1.time < route2.time })) { route in
//                    if route.time >= Date(){
//                        BusArrivalView(route: route)
//                    }
//            }
            .listStyle(.plain)
            
            Spacer()
        }
        .navigationBarTitle(Text(busStop.name),displayMode: .inline)
    }
}

struct BusStopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopDetailView(busStop:BusStop(name: "Centralno groblje", latitude: 45.53174983310974, longitude: 18.671850304788737))
    }
}
