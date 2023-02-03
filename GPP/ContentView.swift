//
//  ContentView.swift
//  GPP
//
//  Created by Saša Marjanović on 17.01.2023..
//

import SwiftUI

struct ContentView: View {
    @State var busStop = BusStop(name: "", latitude: 0, longitude: 0)
    @State var isPresented = false
    
    var body: some View {
    
        MapView(busStop: $busStop, isPresented: $isPresented)
            .edgesIgnoringSafeArea(.top)
            .edgesIgnoringSafeArea(.horizontal)
            .sheet(isPresented: $isPresented, content: {
                BusStopDetailView(busStopName: busStop.name ,busStop: Binding.constant(busStop))
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}
