//
//  CalendarService.swift
//  Calendar
//
//  Created by Chin Chin on 2018/9/2.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import Foundation

class CalendarService {
    lazy private(set) var weekModel: [CalendarWeekModel] = {
        return getSundayOfYears()
    }()
    
    func getSundayOfYears() -> [CalendarWeekModel] {
        let firstSunday = Date().nextSunday
        var result = [CalendarWeekModel(firstDate: firstSunday)]
        
        (1...52).forEach { (_) in
            guard let nextSunday = result.last?.firstDate.nextSunday,
                let previousSunday = result.first?.firstDate.previousSunday
                else { return }
            result.append(CalendarWeekModel(firstDate: nextSunday))
            result.insert(CalendarWeekModel(firstDate: previousSunday), at: 0)
        }
        
        return result
    }
}
