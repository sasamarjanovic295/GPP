//
//  BusStopDetailView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI
import MapKit

struct BusStopDetailView: View {
    
    @Binding var busStop:BusStop
    
    @EnvironmentObject var busStopData: BusStopData
    
    var schedules: [BusStopSchedule]{
        return busStopData.busStopSchedules.filter{ schedule in
            return schedule.busStopId == busStop.id
        }.sorted(by: { $0.time < $1.time })
    }
    
    var routes: [Route] {
        var routes: [Route] = []
        for schedule in self.schedules {
            let route = busStopData.routes.filter{  route in
                return route.id == schedule.routeId
            }.first
            routes.append(route!)
        }
        return routes
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
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 15, trailing: 0))
                
                HStack{
                    Text("LINIJE")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5))
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
            
            List(schedules) { schedule in
                if schedule.time >= Date(){
                    BusArrivalView(schedule: schedule)
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .navigationBarTitle(Text(busStop.name),displayMode: .inline)
    }
}

struct BusStopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopDetailView(busStop:Binding.constant(BusStop(
            name: "Centralno groblje",
            latitude: 45.53174983310974,
            longitude: 18.671850304788737)))
        .environmentObject(BusStopData())
    }
}
