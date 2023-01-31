//
//  BusStopData.swift
//  GPP
//
//  Created by Saša Marjanović on 18.01.2023..
//

import Foundation
import MapKit

struct BusStop : Identifiable{
    var id = UUID().uuidString
    let name: String
    let coordinate: CLLocationCoordinate2D
}
