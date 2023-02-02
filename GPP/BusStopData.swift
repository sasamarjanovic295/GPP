//
//  BusStopData.swift
//  GPP
//
//  Created by Saša Marjanović on 18.01.2023..
//

import Foundation
import FirebaseDatabase


struct BusStop : Identifiable, Codable {
    var id = UUID().uuidString
    let name: String
    let latitude: Double
    let longitude: Double
}


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

class BusStopData: ObservableObject{
    
    @Published var busStops:[BusStop] = []
    @Published var routes: [Route] = []
    @Published var busStopSchedules: [BusStopSchedule] = []
    
    @MainActor @Sendable
    func fetchBusStops() async{
        do{
            let url = URL(string: "https://gppbase-default-rtdb.firebaseio.com/busStops.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try decoder.decode([String: BusStop].self, from: data)
            busStops = [BusStop](json.values)
        }catch let error{
            print(error)
        }
    }
    
    @MainActor @Sendable
    func sendBusStop(busStop: BusStop) async{
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(busStop)
            let url = URL(string: "https://gppbase-default-rtdb.firebaseio.com/busStops.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let(_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    
    @MainActor @Sendable
    func fetchRoutes() async{
        do{
            let url = URL(string: "https://gppbase-default-rtdb.firebaseio.com/routes.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try decoder.decode([String: Route].self, from: data)
            routes = [Route](json.values)
        }catch let error{
            print(error)
        }
    }
    
    @MainActor @Sendable
    func sendRoutes(route: Route) async{
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(route)
            let url = URL(string: "https://gppbase-default-rtdb.firebaseio.com/routes.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let(_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
    
    
    @MainActor @Sendable
    func fetchBusStopSchedule() async{
        do{
            let url = URL(string: "https://gppbase-default-rtdb.firebaseio.com/busStopSchedules.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            let json = try decoder.decode([String: BusStopSchedule].self, from: data)
            busStopSchedules = [BusStopSchedule](json.values)
        }catch let error{
            print(error)
        }
    }
    
    @MainActor @Sendable
    func sendBusStopSchedule(busStopSchedule: BusStopSchedule) async{
        do {
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            let json = try encoder.encode(busStopSchedule)
            let url = URL(string: "https://gppbase-default-rtdb.firebaseio.com/busStopSchedules.json")!
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = json
            
            let(_, response) = try await URLSession.shared.data(for: request)
            print(response)
        }catch let error {
            print(error)
        }
    }
}
