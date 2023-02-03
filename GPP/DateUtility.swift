//
//  DateUtility.swift
//  GPP
//
//  Created by Saša Marjanović on 03.02.2023..
//

import Foundation


class DateUtility: ObservableObject{
    
    private let formatter: DateFormatter = DateFormatter()
    
    func display24HoursTime(date:Date) -> String {
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func dateForComparing(existingDate: Date) -> Date{
        let currentDate = Date()
        let existingDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: existingDate)
        let currentTimeComponents = Calendar.current.dateComponents([.hour, .minute, .second], from: currentDate)
        
        var newDateComponents = existingDateComponents
        newDateComponents.hour = currentTimeComponents.hour
        newDateComponents.minute = currentTimeComponents.minute
        newDateComponents.second = currentTimeComponents.second
        let newDate = Calendar.current.date(from: newDateComponents)!
        return newDate
    }
    
    func getNewDateWithTimeFromToday(_ date: Date) -> Date {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.hour, .minute, .second], from: date)
        return calendar.date(bySettingHour: dateComponents.hour!, minute: dateComponents.minute!, second: dateComponents.second!, of: Date())!
    }
}
