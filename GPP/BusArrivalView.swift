//
//  BusArrivalView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI



struct BusArrivalView: View {
    
    @EnvironmentObject var busStopData: BusStopData
    
    @EnvironmentObject var dateUtility: DateUtility
    
    var schedule:BusStopSchedule
    
    var route: Route {
        return busStopData.routes.filter{ route in
            return route.id == schedule.routeId
        }.first!
    }
    
    @State private var isCommingInOneHour = false
    
    @State private var isArrived = false
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    private var todaySchedule: Date {
        return dateUtility.getNewDateWithTimeFromToday(schedule.time)
    }
    
    
    var body: some View {
        
        HStack{
            Text(route.number)
                .font(.title2)
                .foregroundColor(.blue)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
            Text(route.destination)
                .font(.title2)
            Spacer()
                
            if isArrived
            {
                Text("Stigao")
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            else if isCommingInOneHour{
                Text(todaySchedule, style: .relative)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            else{
                Text(dateUtility.display24HoursTime(date: todaySchedule))
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
        .task {
            self.isCommingInOneHour = todaySchedule.timeIntervalSince(Date()) < 3600
            self.isArrived = todaySchedule <= Date()
        }
        .onReceive(timer){ time in
            self.isCommingInOneHour = todaySchedule.timeIntervalSince(Date()) < 3600
            self.isArrived = todaySchedule <= Date()
        }
    }
}

struct BusArrivalView_Previews: PreviewProvider {
    static var previews: some View {
        BusArrivalView( schedule: BusStopSchedule(busStopId: "3", routeId: "3",
                        time: Date(timeIntervalSinceNow: TimeInterval(3630))))
        .environmentObject(BusStopData())
        .environmentObject(DateUtility())
    }
}
