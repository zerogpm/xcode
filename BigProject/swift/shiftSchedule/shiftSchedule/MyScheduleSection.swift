//
//  MyScheduleSection.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-25.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation

class MyScheduleSection{
    
    var heading : String
    var mySchedules : [MySchedule]
    
    init(heading:String, objects: [MySchedule]) {
        self.heading = heading
        self.mySchedules = objects
    }
}