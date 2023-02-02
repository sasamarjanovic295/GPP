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
    
    var schedules: [BusStopSchedule]{
        return busStopData.busStopSchedules.filter{ schedule in
            return schedule.busStopId == busStop.id
        }
    }
    
    var routes: [Route] {
        var routes: [Route] = []
        for schedule in self.schedules {
            let route = busStopData.routes.filter{  route in
                return route.id == schedule.routeId
            }.first
            routes.append(route!)
        }
        return routes.sorted(by: { $0.destination < $1.destination})
    }
    
    var routeNumbers: [String]{
        var numbers:[String] = []
        for route in self.routes {
            if !numbers.contains(route.number) {
                numbers.append(route.number)
            }
        }
        return numbers.sorted(by: { $0 < $1})
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
                ForEach(routes.prefix(4)) { route in
                    if route.id != routes.prefix(4).last?.id {
                        Text(route.destination + ",")
                            .fixedSize()
                            .foregroundColor(.black.opacity(0.7))
                    }
                    else{
                        Text(route.destination + "...")
                            .foregroundColor(.black.opacity(0.7))
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
    }
}
