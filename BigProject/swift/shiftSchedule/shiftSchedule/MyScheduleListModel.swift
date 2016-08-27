//
//  MyScheduleListModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-22.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol MyScheduleListDelegate {
    func dataReady()
}

class MyScheduleListMode {
    
    var section = [MyScheduleSection]()
    var delegate:MyScheduleListDelegate?
    var dateRang:String?
    
    func getMyScheduleList(id:String, myComanyId:String, date:String){
        
        let url = getMySchedulerApi + "?id=\(id)&companyId=\(myComanyId)&startDate=\(date)"
        print(url)
    
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    
                    
                    if let startWeek = json["startWeeks"].string , endWeek = json["endWeeks"].string {
                        
                        self.dateRang = "\(startWeek) to \(endWeek)"

                    }
                    
                    var sectionsArray = [MyScheduleSection]()
                    
                    for(_, scheduler) in json["schedules"] {
                        
                        var objects = [MySchedule]()
                        
                        for(_,subScheduler) in scheduler {
                            
                            for(_,item) in subScheduler["items"] {
                                
                                if let presetName = item["presetName"].string, startDateTime = item["startDateTime"].string, date = item["date"].string, status = item["status"].string,
                                    postion = item["position"].string, scheduleId = item["schedule_id"].int, swappableTime = item["swappableTime"].arrayObject, swapId = item["swapId"].arrayObject {
                                    let tempObject = MySchedule()
                                    tempObject.presetName = presetName
                                    tempObject.scheduleId = String(scheduleId)
                                    tempObject.timeRange = startDateTime
                                    tempObject.date = date
                                    tempObject.position = postion
                                    tempObject.status = status
                                    tempObject.swappableTime = swappableTime
                                    tempObject.swappableId = swapId
                                    objects.append(tempObject)
                                }
                                
                            }//item
                            
                        }//subScheduler
                        
                        if let sectionDate = scheduler["schedules"]["sectionDate"].string {
                            sectionsArray.append(MyScheduleSection(heading: sectionDate, objects: objects))
                        }
                        
                    }//scheduler
                    self.section = sectionsArray
                    
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