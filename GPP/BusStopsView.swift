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
    
    @EnvironmentObject var busStopData: BusStopData
    
    var foundStops: [BusStop]{
        return busStopData.busStops.filter{ busStop in
            return busStop.name.lowercased()
                .contains(query.lowercased())
        }
        .sorted(by: { $0.name < $1.name})
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
                        NavigationLink(destination: BusStopDetailView(busStop: Binding.constant(busStop))){
                            BusStopView(busStop: Binding.constant(busStop))
                        }
                    }
                    .listStyle(.plain)
                    .frame(alignment: .leading)
                }
                else {
                    List($busStopData.busStops) { busStop in
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
            .environmentObject(BusStopData())
    }
}
