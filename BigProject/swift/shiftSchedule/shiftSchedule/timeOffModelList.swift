//
//  timeOffModelList.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-07-06.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol timeOffModelListDelegate {
    func dataReady()
}

class timeOffModelList: NSObject {
    var timeOffList = [TimeOff]()
    var delegate:timeOffModelListDelegate?
    
    func getTimeOffList(userId:String, companyId:String, availabilityType:String){
        
        var tempTimeOffListObjects = [TimeOff]()
        
        let url = "https://app19.pushoperations.com/api/v1/ios/timeOffList?companyId=\(companyId)&employeeId=\(userId)&availabilityType=\(availabilityType)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for(_, timeOffData) in json {
                        let timeOff = TimeOff()
                        
                        guard let id = timeOffData["id"].int else {print("id problem"); return}
                        guard let type = timeOffData["type"].string else {print("type problem"); return}
                        guard let startDate = timeOffData["start_datetime"].string else {print("start_datetime problem"); return}
                        guard let endDate = timeOffData["end_datetime"].string else {print("end_datetime problem"); return}
                        guard let notes = timeOffData["notes"].string else {print("notes problem"); return}
                        guard let isApproved = timeOffData["is_approved"].int else {print("id problem"); return}
                        
                        timeOff.id = String(id)
                        timeOff.type = type
                        timeOff.startDate = startDate
                        timeOff.endDate = endDate
                        timeOff.notes = notes
                        timeOff.isApproved = String(isApproved)
                        tempTimeOffListObjects.append(timeOff)
                    }
                    
                    self.timeOffList = tempTimeOffListObjects
                    //Notify the delegate that the data is ready
                    if self.delegate != nil {
                        self.delegate!.dataReady()
                    }
                }
            case .Failure(let error):
                print(error)
            }
        }
        
    }
    
}