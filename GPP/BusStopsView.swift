//
//  BusStopsView.swift
//  GPP
//
//  Created by Saša Marjanović on 28.01.2023..
//

import SwiftUI
import MapKit
import UIKit

struct BusStopsView: View {
    
    @State var query: String = ""
    
    @State var busStops: [BusStop] = [
        BusStop(name: "Centralno groblje",
            coordinate: CLLocationCoordinate2D(latitude: 45.53174983310974, longitude: 18.671850304788737)),
        BusStop(name: "Cesting",
            coordinate: CLLocationCoordinate2D(latitude: 45.53894023803806, longitude: 18.67270921720016)),
        BusStop(name: "Nadvoznjak",
            coordinate: CLLocationCoordinate2D(latitude: 45.54159885719651, longitude:  18.674880320881)),
        BusStop(name: "Mercator",
            coordinate: CLLocationCoordinate2D(latitude: 45.54480067313245, longitude: 18.677720239942886)),
        BusStop(name: "Mercator",
            coordinate: CLLocationCoordinate2D(latitude: 45.54480067313245, longitude: 18.677720239942886)),
        BusStop(name: "Mercator",
            coordinate: CLLocationCoordinate2D(latitude: 45.54480067313245, longitude: 18.677720239942886)),
        BusStop(name: "Mercator",
            coordinate: CLLocationCoordinate2D(latitude: 45.54480067313245, longitude: 18.677720239942886)),
        BusStop(name: "Mercator",
            coordinate: CLLocationCoordinate2D(latitude: 45.54480067313245, longitude: 18.677720239942886)),
        BusStop(name: "Mercator",
            coordinate: CLLocationCoordinate2D(latitude: 45.54480067313245, longitude: 18.677720239942886))
    ]

    
    var foundStops: [BusStop]{
        return busStops.filter{ busStop in
            return busStop.name.lowercased()
                .contains(query.lowercased())
        }
    }
    
    var body: some View {
        
        VStack{
            
            VStack{
                Text("Stanice")
                    .font(.title2)
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title2)
                    TextField("Potrazi stanicu", text: $query)
                        .textFieldStyle(.roundedBorder)
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 20, trailing: 16))
            
            if query != "" {
                List(foundStops) { busStop in
                    BusStopView(busStop: busStop)
                }
                .listStyle(.plain)
                .frame(alignment: .leading)
            }
            else {
                List(busStops) { busStop in
                    BusStopView(busStop: busStop)
                }
                .listStyle(.plain)
                .frame(alignment: .leading)
            }
            
            Spacer()
        }
    }
}

struct BusStopsView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopsView()
    }
}
