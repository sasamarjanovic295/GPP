//
//  BusStop.swift
//  GPP
//
//  Created by Saša Marjanović on 01.02.2023..
//

import Foundation

struct BusStop : Identifiable, Codable {
    var id = UUID().uuidString
    let name: String
    let latitude: Double
    let longitude: Double
    
    func toDictionary() -> [String: Any] {
        return [
            "id": id,
            "name": name,
            "latitude": latitude,
            "longitude": longitude
        ]
    }
}
