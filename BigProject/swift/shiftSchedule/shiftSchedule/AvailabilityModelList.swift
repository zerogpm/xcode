//
//  AvailabilityModelList.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-06-30.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol AvailabilityModelDelegate {
    func dataReady()
}

class AvailabilityModelList {
    
    var id = ""
    var employeeId = ""
    var availabilityData = [AvailabilityHistory]()
    var delegate:AvailabilityModelDelegate?
    
    init() {
        
    }
    
    init(id:String, employeeId:String) {
        self.id = id
        self.employeeId = employeeId
    }
    
    func getAvailabilityHistory(userId : String){
        
        var tempHistoryObjects = [AvailabilityHistory]()
        let url = availabilityHistory + "/\(userId)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    
                    for(_, history) in json {
                        
                        let tempObject = AvailabilityHistory()
                        
                        guard let id = history["id"].int else {print("error on json id"); return}
                        guard let numDaysWork = history["num_days_work"].int else {print("error on json numDaysWork"); return}
                        guard let approved = history["approved"].int else {print("error on json approved"); return}
                        guard let effectiveStartdate = history["effective_startdate"].string else {print("error on json effectiveStartdate"); return}
                        guard let effectiveEndDate = history["effective_enddate"].string else {print("error on json effectiveStartdate"); return}
                        guard let mondayAvailable = history["monday_available"].int else {print("error on json mondayAvailable"); return}
                        guard let mondayStart = history["monday_start"].string else {print("error on json mondayStart"); return}
                        guard let mondayEnd = history["monday_end"].string else {print("error on json mondayEnd"); return}
                        guard let tuesdayAvailable = history["tuesday_available"].int else {print("error on json tuesdayAvailable"); return}
                        guard let tuesdayStart = history["tuesday_start"].string else {print("error on json tuesdayStart"); return}
                        guard let tuesdayEnd = history["tuesday_end"].string else {print("error on json tuesdayEnd"); return}
                        guard let wednesdayAvailable = history["wednesday_available"].int else {print("error on json wednesdayAvailable"); return}
                        guard let wednesdayStart = history["wednesday_start"].string else {print("error on json wednesdayStart"); return}
                        guard let wednesdayEnd = history["wednesday_end"].string else {print("error on json wednesdayEnd"); return}
                        guard let thursdayAvailable = history["thursday_available"].int else {print("error on json thursdayAvailable"); return}
                        guard let thursdayStart = history["thursday_start"].string else {print("error on json thursdayStart"); return}
                        guard let thursdayEnd = history["thursday_end"].string else {print("error on json thursdayEnd"); return}
                        guard let fridayAvailable = history["friday_available"].int else {print("error on json fridayAvailable"); return}
                        guard let fridayStart = history["friday_start"].string else {print("error on json fridayStart"); return}
                        guard let fridayEnd = history["friday_end"].string else {print("error on json fridayEnd"); return}
                        guard let saturdayAvailable = history["saturday_available"].int else {print("error on json saturdayAvailable"); return}
                        guard let saturdayStart = history["saturday_start"].string else {print("error on json saturdayStart"); return}
                        guard let saturdayEnd = history["saturday_end"].string else {print("error on json saturdayEnd"); return}
                        guard let sundayAvailable = history["sunday_available"].int else {print("error on json sundayAvailable"); return}
                        guard let sundayStart = history["sunday_start"].string else {print("error on json sundayStart"); return}
                        guard let sundayEnd = history["sunday_end"].string else {print("error on json sundayEnd"); return}
                        
                        tempObject.id = String(id)
                        tempObject.numDaysWork = String(numDaysWork)
                        tempObject.approved = String(approved)
                        tempObject.effectiveStartdate = effectiveStartdate
                        tempObject.effectiveEndDate = effectiveEndDate
                        tempObject.mondayAvailable = String(mondayAvailable)
                        tempObject.mondayStart = mondayStart
                        tempObject.mondayEnd = mondayEnd
                        tempObject.tuesdayAvailable = String(tuesdayAvailable)
                        tempObject.tuesdayStart = tuesdayStart
                        tempObject.tuesdayEnd = tuesdayEnd
                        tempObject.wednesdayAvailable = String(wednesdayAvailable)
                        tempObject.wednesdayStart = wednesdayStart
                        tempObject.wednesdayEnd = wednesdayEnd
                        tempObject.thursdayAvailable = String(thursdayAvailable)
                        tempObject.thursdayStart = thursdayStart
                        tempObject.thursdayEnd = thursdayEnd
                        tempObject.fridayAvailable = String(fridayAvailable)
                        tempObject.fridayStart = fridayStart
                        tempObject.fridayEnd = fridayEnd
                        tempObject.saturdayAvailable = String(saturdayAvailable)
                        tempObject.saturdayStart = saturdayStart
                        tempObject.saturdayEnd = saturdayEnd
                        tempObject.sundayAvailable = String(sundayAvailable)
                        tempObject.sundayStart = sundayStart
                        tempObject.sundayEnd = sundayEnd
                        
                        tempHistoryObjects.append(tempObject)
                    }
                    
                    self.availabilityData = tempHistoryObjects
                    
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
    
    func cancelAvailabilityHistory(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let parameters: [String:String] = [
            "availability_id": self.id,
            "employee_id" : self.employeeId,
            ]
        
        Alamofire.request(.POST, cancelPendingAvailability, parameters: parameters)
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