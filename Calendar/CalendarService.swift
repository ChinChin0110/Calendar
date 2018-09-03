//
//  CalendarService.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/2.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import Foundation

class CalendarService {
    
    private let yearRange: Int
    let thisWeek: CalendarWeekModel
    
    lazy private(set) var weekModels: [CalendarWeekModel] = {
        return getSundayOfYears()
    }()
    
    /// Create weekModels group by same month.
    lazy private(set) var weekModelsGroupByMonth: [[CalendarWeekModel]] = {
        guard let first = weekModels.first else { return [] }
        var temp = weekModels
        temp.removeFirst()
        var result: [[CalendarWeekModel]] = []
        var sectionTemp: [CalendarWeekModel] = [first]
        temp.forEach({ (model) in
            if let last = sectionTemp.last,
                    last.month == model.month {
                sectionTemp.append(model)
            } else {
                result.append(sectionTemp)
                sectionTemp.removeAll()
                sectionTemp.append(model)
            }
        })
        return result
    }()
    
    /**
     Returns a `CalendarService` divided years by week.
     - Parameter yearRange: The range of year from today. 1 year for 52 weeks.
     */
    init(yearRange: Int) {
        assert(yearRange > 0, "yearRange must greater than 0")
        self.yearRange = yearRange
        
        let previousSunday = Date().nextSunday.previousSunday
        self.thisWeek = CalendarWeekModel(firstDate: previousSunday)
    }
    
    /// get all sundays
    private func getSundayOfYears() -> [CalendarWeekModel] {
        let firstSunday = Date().nextSunday
        var result = [CalendarWeekModel(firstDate: firstSunday)]
        
        (1...(yearRange * 26)).forEach { (_) in
            guard let nextSunday = result.last?.firstDate.nextSunday,
                let previousSunday = result.first?.firstDate.previousSunday
                else { return }
            result.append(CalendarWeekModel(firstDate: nextSunday))
            result.insert(CalendarWeekModel(firstDate: previousSunday), at: 0)
        }
        return result
    }
}
