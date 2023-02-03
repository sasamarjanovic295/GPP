//
//  GPPApp.swift
//  GPP
//
//  Created by Saša Marjanović on 17.01.2023..
//

import SwiftUI

@main
struct GPPApp: App {
    
    @StateObject var busStopData: BusStopData = BusStopData()
    
    var dateUtility: DateUtility = DateUtility()
    
    var dataUtility: DataUtility = DataUtility()
    
    var body: some Scene {
        WindowGroup {
            TabView{
                ContentView()
                    .tabItem{
                        Label("Karta", systemImage: "map")
                    }
                BusStopsView()
                    .tabItem{
                        Label("Stanice", systemImage: "pin.circle")
                    }
                RoutesView()
                    .tabItem{
                        Label("Linije", systemImage: "pin.circle")
                    }
            }
            .environmentObject(busStopData)
            .task(busStopData.fetchBusStops)
            .task(busStopData.fetchRoutes)
            .task(busStopData.fetchBusStopSchedule)
            .environmentObject(dateUtility)
            .environmentObject(dataUtility)
        }
    }
}
