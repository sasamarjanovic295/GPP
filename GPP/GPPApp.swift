//
//  GPPApp.swift
//  GPP
//
//  Created by Saša Marjanović on 17.01.2023..
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GPPApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
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
