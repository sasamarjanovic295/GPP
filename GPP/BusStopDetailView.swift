//
//  BusStopDetailView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI
import MapKit

struct BusStopDetailView: View {
    
    @State var busStopName: String?
    
    @Binding var busStop:BusStop
    
    @EnvironmentObject var dateUtility: DateUtility
    
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
    
    var body: some View {
        
        VStack{
            
            VStack{
                
                if busStopName != nil{
                    Text(busStopName!)
                        .font(.title)
                        .padding(EdgeInsets(top: 0,leading: 0, bottom: 10, trailing: 8))
                }
        
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
                    Text("LINIJA")
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
                if schedule.time >= dateUtility.dateForComparing(existingDate: schedule.time){
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
        .environmentObject(DateUtility())
    }
}
