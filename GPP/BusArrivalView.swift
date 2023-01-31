//
//  BusArrivalView.swift
//  GPP
//
//  Created by Saša Marjanović on 29.01.2023..
//

import SwiftUI



struct BusArrivalView: View {
    
    var route: Route
    
    private let formatter: DateFormatter = DateFormatter()
    
    func display24HoursTime() -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: route.time)
    }
    
    @State private var isCommingInOneHour = true
    
    
    
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
                Text(route.time, style: .relative)
                    .font(.title2)
                    .foregroundColor(.blue)
            }
            else{
                Text(display24HoursTime())
                    .font(.title2)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical)
        .task {
            isCommingInOneHour = route.time.timeIntervalSince(Date()) < 3600
        }
    }
}

struct BusArrivalView_Previews: PreviewProvider {
    static var previews: some View {
        BusArrivalView(route: Route(number: "8", destination: "Centralno groblje", time: Date(timeIntervalSinceNow: TimeInterval(3630))))
    }
}
