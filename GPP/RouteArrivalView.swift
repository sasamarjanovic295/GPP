//
//  RouteArrivalView.swift
//  GPP
//
//  Created by Saša Marjanović on 02.02.2023..
//

import SwiftUI

struct RouteArrivalView: View {
    
    var route: Route
    
    var schedule: BusStopSchedule
    
    @State private var isCommingInOneHour = false
    
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    @EnvironmentObject var busStopData: BusStopData
    @EnvironmentObject var dateUtility: DateUtility
    
    var busStop: BusStop {
        return busStopData.busStops.filter{ busStop in
            return busStop.id == schedule.busStopId
        }.first!
    }
    
    
    var body: some View {
        HStack{
            if schedule.time < dateUtility.dateForComparing(existingDate: schedule.time){
                Image(systemName: "circle.fill")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
            }
            else{
                Image(systemName: "circle")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
            }
            
            Text(busStop.name)
                .font(.title2)
            Spacer()
            
            if isCommingInOneHour {
                
                if schedule.time <= dateUtility.dateForComparing(existingDate: schedule.time)
                {
                    Text("Stigao")
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                else{
                    Text(schedule.time, style: .relative)
                        .font(.title2)
                        .foregroundColor(.blue)
                }
                
            }
            else{
                Text(dateUtility.display24HoursTime(date: schedule.time))
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
        .task {
            self.isCommingInOneHour = schedule.time.timeIntervalSince(dateUtility.dateForComparing(existingDate: schedule.time)) < 3600
        }
        .onReceive(timer){ time in
            self.isCommingInOneHour = schedule.time.timeIntervalSince(dateUtility.dateForComparing(existingDate: schedule.time)) < 3600
        }
    }
}

struct RouteArrivalView_Previews: PreviewProvider {
    static var previews: some View {
        RouteArrivalView(route: Route(number: "3", destination: "retfala"),
                         schedule: BusStopSchedule(busStopId: "3", routeId: "3",
                                                   time: Date(timeIntervalSinceNow: TimeInterval(3630))))
        .environmentObject(BusStopData())
        .environmentObject(DateUtility())
    }
}
