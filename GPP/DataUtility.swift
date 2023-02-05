//
//  DataUtility.swift
//  GPP
//
//  Created by Saša Marjanović on 03.02.2023..
//

import Foundation
import SwiftUI

class DataUtility: ObservableObject{
    
    func getSchedulesWithBusStopId(schedules: [BusStopSchedule], id: String) -> [BusStopSchedule]{
        return schedules.filter{ schedule in
            return schedule.busStopId == id
        }.sorted(by: {$0.time < $1.time})
    }
    
    func getRoutesWithSchedules(routes: [Route], schedules: [BusStopSchedule]) -> [Route] {
        var newRoutes: [Route] = []
        for schedule in schedules {
            let route = routes.filter{  route in
                return route.id == schedule.routeId
            }.first
            newRoutes.append(route!)
        }
        return newRoutes.sorted(by: { $0.destination < $1.destination})
    }
    
    func getRouteNumbers(routes: [Route]) -> [String] {
        var numbers:[String] = []
        for route in routes {
            if !numbers.contains(route.number) {
                numbers.append(route.number)
            }
        }
        return numbers.sorted(by: { $0 < $1})
    }
    
    func getRouteDestinations(routes: [Route]) -> [String] {
        var dest:[String] = []
        for route in routes {
            if !dest.contains(route.destination) {
                dest.append(route.destination)
            }
        }
        return dest.sorted(by: { $0 < $1})
    }
    
    func getBusStopDestinations(busStopId: String, schedules: [BusStopSchedule], routes: [Route]) -> [String]{
        let schs = self.getSchedulesWithBusStopId(schedules: schedules, id: busStopId)
        let rts = self.getRoutesWithSchedules(routes: routes, schedules: schs)
        return self.getRouteDestinations(routes: rts)
    }
}
