//
//  Date+Extension.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/2.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import Foundation

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    var startOfWeek: Date {
        return Calendar.gregorian.date(from: Calendar.gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self))!
    }
    var nextSunday: Date {
        return Calendar.gregorian.date(byAdding: DateComponents(weekday: 1, weekOfYear: 1), to: startOfWeek)!
    }
    var previousSunday: Date {
        return Calendar.gregorian.date(byAdding: DateComponents(weekday: 1, weekOfYear: -1), to: startOfWeek)!
    }
}
