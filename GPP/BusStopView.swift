//
//  BusStopView.swift
//  GPP
//
//  Created by Saša Marjanović on 28.01.2023..
//

import SwiftUI
import MapKit


extension String: Identifiable {
    public var id: String { self }
}

struct BusStopView: View {
    
    var busStop: BusStop
    let busStopRoutes:[String] = ["1","2", "3", "4", "5"]
    let busStopDestinations:[String] = ["Retfala", "Donji grad", "Jug", "Tvrdja", "Kampus"]
    
    var body: some View {
        NavigationView{
            NavigationLink(destination: BusStopDetailView(busStop: busStop)){
                VStack{
                    HStack{
                        Text(busStop.name)
                            .font(.title2)
                            .foregroundColor(.black)
                        Spacer()
                    }
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 1, trailing: 0))
                    HStack{
                        Image(systemName: "bus.fill")
                            .foregroundColor(.blue)
                            .padding(EdgeInsets(top: 0,leading: 0, bottom: 1, trailing: 8))
                        ForEach(busStopRoutes) { route in
                            if route != busStopRoutes.last {
                                Text(route + ",")
                                    .foregroundColor(.black.opacity(0.7))
                            }
                            else{
                                Text(route)
                                    .foregroundColor(.black.opacity(0.7))
                            }
                        }
                        Spacer()
                    }
                    HStack{
                        Image(systemName: "arrow.right")
                            .foregroundColor(.blue)
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                        ForEach(busStopDestinations.prefix(4)) { destination in
                            if destination != busStopDestinations.prefix(4).last {
                                Text(destination + ",")
                                    .fixedSize()
                                    .foregroundColor(.black.opacity(0.7))
                            }
                            else{
                                Text(destination + "...")
                                    .foregroundColor(.black.opacity(0.7))
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

struct BusStopView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopView(busStop: BusStop(name: "Cesting", coordinate: CLLocationCoordinate2D(latitude: 45.53894023803806, longitude: 18.67270921720016)))
    }
}
