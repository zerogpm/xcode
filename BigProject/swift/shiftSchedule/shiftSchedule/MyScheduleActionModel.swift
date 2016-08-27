//
//  MyScheduleActionModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-05-03.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MyScheduleActionModel {
    
    var action: String = ""
    var employeeId : String = ""
    var currentShiftId : String = ""
    var swapShiftId : String = ""
    var comments : String = ""
    
    init(action:String, employeeId:String, current_shift_id:String, swap_shift_id:String, comments:String) {
        self.action = action
        self.employeeId = employeeId
        self.currentShiftId = current_shift_id
        self.swapShiftId = swap_shift_id
        self.comments = comments
    }
    
    func myScheduleShiftSwap(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        var swapshiftId = ""
        
        if self.action == MyScheduleSwap {
            swapshiftId = self.swapShiftId
        } else {
            swapshiftId = "-1"
        }
        
        let postParameters: [String:String] = [
            "employee_id" : self.employeeId,
            "current_shift_id" : self.currentShiftId,
            "swap_shift_id" : swapshiftId,
            "comments" : self.comments
        ]
        
        Alamofire.request(.POST, requestMyscheduleShift, parameters: postParameters)
            .responseJSON { response in
                switch response.result {
                case .Success(let value):
                    completionHandler(value as? NSDictionary, nil)
                case .Failure(let error):
                    completionHandler(nil, error)
                }
        }
        
    }
    
    func cancelAction(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let postParameters: [String:String] = [
            "current_shift_id" : self.currentShiftId,
            "action" : "cancel",
            "user" : "employee"
        ]
        
        Alamofire.request(.POST, cancelEmployeeReleaseApi, parameters: postParameters)
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