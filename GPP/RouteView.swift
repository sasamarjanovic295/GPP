//
//  RouteView.swift
//  GPP
//
//  Created by Saša Marjanović on 01.02.2023..
//

import SwiftUI

struct RouteView: View {
    
    var route: Route
    
    @EnvironmentObject var dateUtility: DateUtility
    
    @EnvironmentObject var busStopData: BusStopData
    
    var schedules: [BusStopSchedule]{
        return busStopData.busStopSchedules.filter{ schedule in
            return schedule.routeId == route.id
        }.sorted(by: { $0.time < $1.time })
    }
    
    var body: some View {
     
        VStack{
            
            VStack{
                HStack{
                    Text("LINIJE")
                        .font(.subheadline)
                        .foregroundColor(.black.opacity(0.7))
                        .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15))
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
                if schedule.time >= dateUtility.dateForComparing(existingDate: schedule.time){
                    RouteArrivalView(route: route, schedule: schedule)
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
        .navigationBarTitle(Text("Linija " + route.number),displayMode: .inline)
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView(route: Route(number: "3", destination: "retfala"))
            .environmentObject(BusStopData())
            .environmentObject(DateUtility())
    }
}
