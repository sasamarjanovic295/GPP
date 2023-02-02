//
//  BusStopData.swift
//  GPP
//
//  Created by Saša Marjanović on 18.01.2023..
//

import Foundation
import FirebaseDatabase


struct Route: Identifiable, Codable {
    var id = UUID().uuidString
    let number: String
    let destination: String
}

struct BusStopSchedule: Identifiable, Codable {
    var id = UUID().uuidString
    let busStopId: String
    let routeId: String
    let time: Date
}
