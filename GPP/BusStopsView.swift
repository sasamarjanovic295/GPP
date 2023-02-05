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
    @EnvironmentObject var dataUtility: DataUtility
    
    var foundStops: [BusStop]{
        return busStopData.busStops.filter{ busStop in
            return busStop.name.lowercased().contains(query.lowercased()) ||
                busStopHasQueriedDestination(busStop: busStop)
        }
        .sorted(by: { $0.name < $1.name})
    }
    
    func busStopHasQueriedDestination(busStop: BusStop) -> Bool {
        let busStopDests = dataUtility.getBusStopDestinations(
            busStopId: busStop.id, schedules: busStopData.busStopSchedules, routes: busStopData.routes)
        for busStopDest in busStopDests {
            if busStopDest.lowercased().contains(query.lowercased()){
                return true
            }
        }
        return false
    }
    
    var body: some View {
        
        NavigationView{
        
            VStack{
                
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                        .font(.title2)
                    TextField("Potrazi stanicu ili odrediste", text: $query)
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
                    List($busStopData.busStops.sorted(by: { $0.wrappedValue.name < $1.wrappedValue.name})) { busStop in
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
            .environmentObject(DataUtility())
    }
}
