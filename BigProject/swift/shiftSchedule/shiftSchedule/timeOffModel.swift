//
//  timeOffModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-07.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class timeOffModel: NSObject {
    
    var availabilityId:String = ""
    var startDate:String = ""
    var endDate:String = ""
    var customDate:String = ""
    var userId:String = ""
    var companyId:String = ""
    var availabilityType:String = ""
    
    init(availabilityId:String) {
        self.availabilityId = availabilityId
    }
    
    init(startDate:String, endDate:String,customDate:String, userId:String, companyId:String,availabilityType:String) {
        self.availabilityType = availabilityType
        self.startDate = startDate
        self.endDate = endDate
        self.customDate = customDate
        self.userId = userId
        self.companyId = companyId
    }
    
    func submitCustomTime(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let parameters : [String:String] = [
            "customStartTime" : self.startDate,
            "customEndTime": self.endDate,
            "employeeId" : self.userId,
            "companyId" : self.companyId,
            "availability_type" : self.availabilityType,
            "customDate" : self.customDate
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
    
    func cancelTimeOff(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let parameters : [String:String] = [
            "availabilityId" : self.availabilityId
        ]
        
        Alamofire.request(.POST, timeOffCancel, parameters: parameters)
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