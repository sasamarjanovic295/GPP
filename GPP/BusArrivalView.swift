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
    let timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        
        HStack{
            Text(route.number)
                .font(.title2)
                .foregroundColor(.blue)
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 35))
            Text(route.destination)
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
            self.isCommingInOneHour = schedule.time
                .timeIntervalSince(dateUtility.dateForComparing(existingDate: schedule.time)) < 3600
        }
        .onReceive(timer){ time in
            self.isCommingInOneHour = schedule.time
                .timeIntervalSince(dateUtility.dateForComparing(existingDate: schedule.time)) < 3600
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
