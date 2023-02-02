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
        BusStop(name: "Centralno groblje",latitude: 45.53174983310974, longitude: 18.671850304788737),
        BusStop(name: "Cesting",latitude: 45.53894023803806, longitude: 18.67270921720016),
        BusStop(name: "Nadvoznjak",latitude: 45.54159885719651, longitude:  18.674880320881),
        BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886),
        BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886),
        BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886),
        BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886),
        BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886),
        BusStop(name: "Mercator",latitude: 45.54480067313245, longitude: 18.677720239942886)]
    
    var foundStops: [BusStop]{
        return busStops.filter{ busStop in
            return busStop.name.lowercased()
                .contains(query.lowercased())
        }
    }
    
    var body: some View {
        
        NavigationView{
        
            VStack{
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title2)
                    TextField("Potrazi stanicu", text: $query)
                        .textFieldStyle(.roundedBorder)
                }.padding(EdgeInsets(top: 18, leading: 18, bottom: 5, trailing: 18))

                if query != "" {
                    List(foundStops) { busStop in
                        NavigationLink(destination: BusStopDetailView(busStop: busStop)){
                            BusStopView(busStop: busStop)
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                else {
                    List(busStops) { busStop in
                        NavigationLink(destination: BusStopDetailView(busStop: busStop)){
                            BusStopView(busStop: busStop)
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                
                Spacer()
            }
            .navigationBarTitle(Text("Stanice"),displayMode: .inline)
        }
    }
}

struct BusStopsView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopsView()
    }
}
