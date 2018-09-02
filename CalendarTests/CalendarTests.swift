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
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            let firstSunday = Date().nextSunday
            var result = [firstSunday]
            (1...52).forEach { (_) in
                guard let nextSunday = result.last?.nextSunday,
                    let previousSunday = result.first?.previousSunday
                    else { return }
                result.append(nextSunday)
                result.insert(previousSunday, at: 0)
            }
//
//            let formatter = DateFormatter()
//            formatter.timeZone = TimeZone(secondsFromGMT: 0)
//            formatter.timeStyle = .none
//            formatter.dateFormat = "yyyy-MM-dd"
//
//            result.forEach { (date) in
//                print(formatter.string(from: date))
//            }
        }
    }
    
}
