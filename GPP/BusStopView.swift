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
    
    @Binding var busStop: BusStop
    
    @EnvironmentObject var busStopData: BusStopData
    
    @EnvironmentObject var dataUtility: DataUtility
    
    var schedules: [BusStopSchedule]{
        return dataUtility.getSchedulesWithBusStopId(
            schedules: busStopData.busStopSchedules, id: busStop.id)
    }
    
    var routes: [Route] {
        return dataUtility.getRoutesWithSchedules(
            routes: busStopData.routes, schedules: schedules)
    }
    
    var routeNumbers: [String]{
        return dataUtility.getRouteNumbers(routes: routes)
    }
    
    var routeDestinations: [String]{
        return dataUtility.getRouteDestinations(routes: routes)
    }
    
    var body: some View {
        
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
                ForEach(routeNumbers) { number in
                    if number != routeNumbers.last {
                        Text(number + ",")
                            .foregroundColor(.black.opacity(0.7))
                    }
                    else{
                        Text(number)
                            .foregroundColor(.black.opacity(0.7))
                    }
                }
                Spacer()
            }
            HStack{
                Image(systemName: "arrow.right")
                    .foregroundColor(.blue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
                ForEach(routeDestinations.prefix(3)) { route in
                    if routeDestinations.count >= 3 {
                        if route == routeDestinations.prefix(3).last {
                            Text(route + "...")
                                .foregroundColor(.black.opacity(0.7))
                        }
                        else{
                            Text(route + ",")
                                .foregroundColor(.black.opacity(0.7))
                        }
                    }
                    else{
                        if route != routeDestinations.prefix(3).last {
                            Text(route + ",")
                                .foregroundColor(.black.opacity(0.7))
                        }
                        else{
                            Text(route)
                                .foregroundColor(.black.opacity(0.7))
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct BusStopView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopView(busStop: Binding.constant(BusStop(
            name: "Cesting",
            latitude: 45.53894023803806,
            longitude: 18.67270921720016)))
        .environmentObject(BusStopData())
        .environmentObject(DataUtility())
    }
}
