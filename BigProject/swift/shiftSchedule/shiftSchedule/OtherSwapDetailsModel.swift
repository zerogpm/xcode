//
//  OtherSwapDetailsModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-21.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class OtherSwapDetailsModel {
    
    var currentShiftId :String = ""
    var action: String = ""
    
    init(currentShiftId:String, action:String) {
        self.currentShiftId = currentShiftId
        self.action = action
    }
    
    func shiftSwap(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        var actionType = ""
        
        if self.action == Accpet {
            actionType = "accept"
        } else {
            actionType = "reject"
        }
        
        let postParameters: [String:String] = [
            "user": "employee",
            "current_shift_id" : self.currentShiftId,
            "action" : actionType
            ]
        
        Alamofire.request(.POST, cancelEmployeeSwapApi, parameters: postParameters)
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