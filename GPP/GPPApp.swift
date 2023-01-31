//
//  GPPApp.swift
//  GPP
//
//  Created by Saša Marjanović on 17.01.2023..
//

import SwiftUI

@main
struct GPPApp: App {
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
            }
        }
    }
}
