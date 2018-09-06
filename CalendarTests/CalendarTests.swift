//
//  CalendarTests.swift
//  CalendarTests
//
//  Created by Chin Chin on 2018/9/1.
//  Copyright © 2018年 Chin Chin. All rights reserved.
//

import XCTest
@testable import Calendar

class CalendarTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPerformanceExample() {
        self.measure {
            let service = CalendarService(yearRange: 1)
            _ = service.weekModels
        }
    }
    
    func testsad() {
        self.measure {
            let service = CalendarService(yearRange: 1)
            _ = service.weekModelsGroupByMonth
        }
    }
}
