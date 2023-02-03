//
//  BusStopAnnotationView.swift
//  GPP
//
//  Created by Saša Marjanović on 03.02.2023..
//

import SwiftUI

struct BusStopAnnotationView: View {
    var body: some View {
        Image(uiImage: UIImage(named: "busStop")!)
            .resizable()
            .frame(width: 44, height: 44)
    }
}

struct BusStopAnnotationView_Previews: PreviewProvider {
    static var previews: some View {
        BusStopAnnotationView()
    }
}
