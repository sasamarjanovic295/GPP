//
//  BusArrivalView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI



struct BusArrivalView: View {
    
    @EnvironmentObject var busStopData: BusStopData
    
    var schedule:BusStopSchedule
    
    var route: Route {
        return busStopData.routes.filter{ route in
            return route.id == schedule.routeId
        }.first!
    }
    
    private let formatter: DateFormatter = DateFormatter()
    
    func display24HoursTime() -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: schedule.time)
    }
    
    @State private var isCommingInOneHour = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    
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
                
                if schedule.time <= Date()
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
                Text(display24HoursTime())
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
        .task {
            self.isCommingInOneHour = schedule.time.timeIntervalSince(Date()) < 3600
        }
        .onReceive(timer){ time in
            self.isCommingInOneHour = schedule.time.timeIntervalSince(Date()) < 3600
        }
    }
}

struct BusArrivalView_Previews: PreviewProvider {
    static var previews: some View {
        BusArrivalView( schedule: BusStopSchedule(busStopId: "3", routeId: "3",
                        time: Date(timeIntervalSinceNow: TimeInterval(3630))))
        .environmentObject(BusStopData())
    }
}
