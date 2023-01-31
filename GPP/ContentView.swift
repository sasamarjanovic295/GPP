//
//  ContentView.swift
//  GPP
//
//  Created by Saša Marjanović on 17.01.2023..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            MapView()
        }
        .edgesIgnoringSafeArea(.top)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
    
}
