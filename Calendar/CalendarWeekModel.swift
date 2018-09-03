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
struct CalendarWeekModel: CustomStringConvertible {
    var description: String {
        return "\(formatter.string(from: firstDate)) - \(formatter.string(from: lastDate))"
    }
    
    private var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let firstDate: Date
    let lastDate: Date
    let month: Int
    
    init(firstDate: Date) {
        self.firstDate = firstDate
        
        let acomponents = DateComponents(weekday: 6)
        let lastDate = Calendar.gregorian.date(byAdding: acomponents, to: firstDate)!
        self.lastDate = lastDate
        
        let previousFirstDay = Calendar.gregorian.date(byAdding: DateComponents(weekday: -1), to: firstDate)!
        let month = Calendar.gregorian.component(.month, from: previousFirstDay)
        self.month = month
    }
}
