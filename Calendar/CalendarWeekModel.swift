//
//  CalendarWeekModel.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/2.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import Foundation

/**
 `CalendarWeekModel` represents a week.
 */
struct CalendarWeekModel: CustomStringConvertible, Equatable {
    var description: String {
        return "\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))"
    }
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let startDate: Date
    let endDate: Date
    let month: Int
    let year: Int
    
    init(firstDate: Date) {
        self.startDate = firstDate
        
        let acomponents = DateComponents(weekday: 6)
        let lastDate = Calendar.gregorian.date(byAdding: acomponents, to: firstDate)!
        self.endDate = lastDate
        
        let previousFirstDay = Calendar.gregorian.date(byAdding: DateComponents(weekday: -1), to: firstDate)!
        let month = Calendar.gregorian.component(.month, from: previousFirstDay)
        let year = Calendar.gregorian.component(.year, from: previousFirstDay)
        self.month = month
        self.year = year
    }
    
    func isContains(_ date: Date) -> Bool {
        let year = Calendar.gregorian.component(.year, from: date)
        let month = Calendar.gregorian.component(.month, from: date)

        if year != self.year || month != self.month {
            return false
        }
        
        let day = Calendar.gregorian.component(.day, from: date)
        let previousFirstDay = Calendar.gregorian.date(byAdding: DateComponents(weekday: -1), to: startDate)!
        let previouslastDay = Calendar.gregorian.date(byAdding: DateComponents(weekday: -1), to: endDate)!
        
        let firstDay = Calendar.gregorian.component(.day, from: previousFirstDay)
        let lastDay = Calendar.gregorian.component(.day, from: previouslastDay)
        
        if day < firstDay || day > lastDay {
            return false
        }
        return true
    }
}
