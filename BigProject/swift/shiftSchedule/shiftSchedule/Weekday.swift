//
//  Weekday.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-24.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation

class Weekday {
    
    var weekdayName : String
    var available : Int
    var startTime : String
    var endTime : String
    
    init(weekdayName:String,available:Int, startTime:String, endTime:String) {
        self.weekdayName = weekdayName
        self.available = available
        self.startTime = startTime
        self.endTime = endTime
    }
}