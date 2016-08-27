//
//  DailyShiftModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-07.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol DailyShiftModelDelegate {
    func dataReady()
}

class DailyShiftModel {
    var dailyShiftList = [DailyShift]()
    var delegate:DailyShiftModelDelegate?
    
    func getDailySchedulerList(myCompanyId:String) {
        
        var tempDailySchedulerObjects = [DailyShift]()
        let url = getDailySchedulerAPi + "/\(myCompanyId)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    for(_, scheduler) in json {
                        let dailyScheduleObject = DailyShift()
                        
                        if let fullName = scheduler["fullName"].string {
                            dailyScheduleObject.fullName = fullName
                        } else {
                            dailyScheduleObject.fullName = "No Data"
                        }
                        
                        if let date = scheduler["date"].string {
                            dailyScheduleObject.date = date
                        } else {
                            dailyScheduleObject.date = "No Data"
                        }
                        
                        if let timeRange = scheduler["timeRange"].string {
                            dailyScheduleObject.timeRange = timeRange
                        } else {
                            dailyScheduleObject.date = "No Data"
                        }
                        
                        if let presetName = scheduler["presetName"].string {
                            dailyScheduleObject.presetName = presetName
                        } else {
                            dailyScheduleObject.presetName = "No Data"
                        }
                        
                        if let position = scheduler["position"].string {
                            dailyScheduleObject.position = position
                        } else {
                            dailyScheduleObject.position = "No Data"
                        }
                        tempDailySchedulerObjects.append(dailyScheduleObject)
                    }
                    
                    self.dailyShiftList = tempDailySchedulerObjects
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
    
    func getDailySchedulerByDateList(date:String,myCompanyId:String) {
        
        var tempDailySchedulerObjects = [DailyShift]()
        let url = getDailySchedulerByDateAPi + "?" + "companyId=\(myCompanyId)&date=\(date)"
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for(_, scheduler) in json {
                        let dailyScheduleObject = DailyShift()
                        
                        if let fullName = scheduler["fullName"].string {
                            dailyScheduleObject.fullName = fullName
                        } else {
                            dailyScheduleObject.fullName = "No Data"
                        }
                        
                        if let date = scheduler["date"].string {
                            dailyScheduleObject.date = date
                        } else {
                            dailyScheduleObject.date = "No Data"
                        }
                        
                        if let timeRange = scheduler["timeRange"].string {
                            dailyScheduleObject.timeRange = timeRange
                        } else {
                            dailyScheduleObject.date = "No Data"
                        }
                        
                        if let presetName = scheduler["presetName"].string {
                            dailyScheduleObject.presetName = presetName
                        } else {
                            dailyScheduleObject.presetName = "No Data"
                        }
                        
                        if let position = scheduler["position"].string {
                            dailyScheduleObject.position = position
                        } else {
                            dailyScheduleObject.position = "No Data"
                        }
                        
                        tempDailySchedulerObjects.append(dailyScheduleObject)
                    }
                    
                    self.dailyShiftList = tempDailySchedulerObjects
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
