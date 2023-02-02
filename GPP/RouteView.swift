//
//  RouteView.swift
//  GPP
//
//  Created by Saša Marjanović on 01.02.2023..
//

import SwiftUI

struct RouteView: View {
    
    var route: Route
    
    var body: some View {
        Text("salac")
    }
}

struct RouteView_Previews: PreviewProvider {
    static var previews: some View {
        RouteView(route: Route(number: "3", destination: "retfala"))
    }
}
