//
//  AvailabilityModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-27.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AvailabilityModel: NSObject {
    
    var weekDays = [Weekday]()
    var numberOfDays = ""
    var effectiveStartDate = ""
    var userId = ""
    var companyId = ""
    var startDate = ""
    var endDate = ""
    var reason = ""
    
    init(userId:String, companyId:String, weekDays:[Weekday], numberOfDays:String, effectiveStartDate:String) {
        self.userId = userId
        self.companyId = companyId
        self.weekDays = weekDays
        self.numberOfDays = numberOfDays
        self.effectiveStartDate = effectiveStartDate
    }
    
    init(userId:String) {
        self.userId = userId
    }
    
    init(startDate:String, endDate:String, reason:String, userId:String, companyId:String) {
        self.startDate = startDate
        self.endDate = endDate
        self.reason = reason
        self.userId = userId
        self.companyId = companyId
    }
    
    func submitTimeOff(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let parameters = [
            "date_timeoff_start" : startDate,
            "date_timeoff_end" : endDate,
            "date_timeoff_reason" : reason,
            "employeeId" : userId,
            "companyId" : companyId,
            "availability_type" : "off"
        ]
        
        Alamofire.request(.POST, timeOffSubmit, parameters: parameters)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
    
    func submitAvailability(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        var dayObject = [[String:String]]()
        
        for(_,day) in weekDays.enumerate() {
           let data = ["dayName" : day.weekdayName,
                "startTime" : day.startTime,
                "endTime" : day.endTime,
                "availability" : String(day.available)
            ]
            dayObject.append(data)
        }
        
        let parameters = [
            "employeeId" : self.userId,
            "companyId" : self.companyId,
            "numberOfDays" : self.numberOfDays,
            "effecitveStart" : self.effectiveStartDate,
            "weeksDay" : dayObject
        ]
        
        Alamofire.request(.POST, sendAvailability, parameters: parameters as? [String : AnyObject], encoding: .JSON)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }
    }
}