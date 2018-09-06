//
//  ViewModel.swift
//  Calendar
//
//  Created by Robin chin on 2018/9/4.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import Foundation

class ViewModel {
    let service: CalendarService
    
    enum ModelType {
        case weekModel(CalendarWeekModel)
        case eventModel(Event)
    }
    
    var thisWeek: CalendarWeekModel {
        return service.thisWeek
    }
    
    lazy private(set) var eventWeekModels: [[EventWeekModel]] = {
        return service.weekModelsGroupByMonth.map { (calendarWeekModels) -> [EventWeekModel] in
            return calendarWeekModels.map({ (calendarWeekModel) -> EventWeekModel in
                return EventWeekModel.init(calendarWeekModel, with: [])
            })
        }
    }()
    
    var weekModelsUpdateClosure: ((Int) -> Void)?
    
    var currentDateIndexPath: IndexPath? {
        for (index, weeksOfmonth) in eventWeekModels.enumerated() {
            if let firstWeek = weeksOfmonth.first?.calendarWeekModel,
                firstWeek.month == thisWeek.month,
                firstWeek.year == thisWeek.year {
                return IndexPath(row: 0, section: index)
            }
        }
        return nil
    }
    
    init(yearRange: Int = 1) {
        self.service  = CalendarService(yearRange: yearRange)
        
        // For test
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // change 2 to desired number of seconds
            DispatchQueue.main.async {
                self.updateWeekModels()
            }
        }
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let weeksOfMonth = eventWeekModels[section]
        return weeksOfMonth.map({ (eventWeekModel) -> Int in
            return eventWeekModel.flatSelf().count
        }).reduce(0,+)
    }
    
    func modelTypeFor(_ indexPath: IndexPath) -> ModelType? {
        let weeksOfMonth = eventWeekModels[indexPath.section]

        let flatArray = weeksOfMonth.reduce([]) { (result, weekModel) -> [Any] in
            return result + weekModel.flatSelf()
        }
        
        let value = flatArray[indexPath.row]
        switch value {
        case let value as CalendarWeekModel:
            return ModelType.weekModel(value)
        case let value as Event:
            return ModelType.eventModel(value)
        default:
            return nil
        }
    }
    
    func updateWeekModels() {
        let newDate = Calendar.gregorian.date(byAdding: DateComponents.init(month: 1, weekday: 17), to: Date())!
        let newEvent = KKEvent.init(id: "yoyoyoyo!", date: newDate)
        if let index = service.getGroupIndex(by: newEvent.date) {
            eventWeekModels[index].forEach { (eventModel) in
                if eventModel.calendarWeekModel.isContains(newEvent.date) {
                    eventModel.events.append(newEvent)
                }
            }
            weekModelsUpdateClosure?(index)
        }
    }
}

class EventWeekModel {
    var calendarWeekModel: CalendarWeekModel
    var events: [Event]
    
    init(_ calendarWeekModel: CalendarWeekModel, with events: [Event]) {
        self.calendarWeekModel = calendarWeekModel
        self.events = events
    }
    
    func flatSelf() -> [Any] {
        return events.isEmpty ? [calendarWeekModel] as [Any] : ([calendarWeekModel] + events) as [Any]
    }
}

protocol Event {
    var id: String { get }
    var date: Date { get }
}

struct KKEvent: Event {
    let id: String
    let date: Date
}
