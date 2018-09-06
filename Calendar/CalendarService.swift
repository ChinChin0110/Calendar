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
        return getWeekModelsOfYears()
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
    
    func getWeekModel(by date: Date) -> CalendarWeekModel? {
        for weekModel in weekModels {
            if weekModel.isContains(date) {
                return weekModel
            }
        }
        return nil
    }
    
    func getGroupIndex(by date: Date) -> Int? {
        guard let weekModelFromDate = getWeekModel(by: date) else { return nil }
        for (index, weekModels) in weekModelsGroupByMonth.enumerated() {
            if let firstWeek = weekModels.first,
                firstWeek.year == weekModelFromDate.year,
                firstWeek.month == weekModelFromDate.month {
                return index
            }
        }
        return nil
    }
    
    /// get all sundays
    private func getWeekModelsOfYears() -> [CalendarWeekModel] {
        let firstSunday = Date().nextSunday
        var result = [CalendarWeekModel(firstDate: firstSunday)]
        
        (1...(yearRange * 26)).forEach { (_) in
            guard let nextSunday = result.last?.startDate.nextSunday,
                let previousSunday = result.first?.startDate.previousSunday
                else { return }
            result.append(CalendarWeekModel(firstDate: nextSunday))
            result.insert(CalendarWeekModel(firstDate: previousSunday), at: 0)
        }
        return result
    }
}
