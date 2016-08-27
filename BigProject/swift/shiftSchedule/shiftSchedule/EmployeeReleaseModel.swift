//
//  EmployeeReleaseModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-19.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol EmployeeReleaseModelDelegate {
    func dataReady()
}

class EmployeeReleaseModel {
    var employeeReleaseRequestList = [EmployeeReleaseRequest]()
    var delegate:EmployeeReleaseModelDelegate?
    
    func getEmployeeReleaseRequest(id:String, myCompanyId:String) {
        
        var tempEmployeeReleaseRequestObjects = [EmployeeReleaseRequest]()
        let url = getReleaseShiftApi + "?id=\(id)&companyId=\(myCompanyId)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for(_, scheduler) in json {
                        let employeeReleaseRequestObject = EmployeeReleaseRequest()
                        
                        if let releaseID = scheduler["releaseID"].int {
                            employeeReleaseRequestObject.releaseId = String(releaseID)
                        } else {
                            employeeReleaseRequestObject.releaseId = "No Data"
                        }
                        
                        if let date = scheduler["scheduledStart"].string {
                            employeeReleaseRequestObject.scheduledStart = date
                        } else {
                            employeeReleaseRequestObject.scheduledStart = "No Data"
                        }
                        
                        if let timeRange = scheduler["timeRange"].string {
                            employeeReleaseRequestObject.timeRange = timeRange
                        } else {
                            employeeReleaseRequestObject.timeRange = "No Data"
                        }
                        
                        tempEmployeeReleaseRequestObjects.append(employeeReleaseRequestObject)
                    }
                    
                    self.employeeReleaseRequestList = tempEmployeeReleaseRequestObjects
                    
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
    
    func deleteMyShiftRelease(currentShiftId:String) {
        let postParameters: [String:String] = [
            "user" : "employee",
            "current_shift_id" : currentShiftId,
            "action" : "cancel"
            ]
        let url = cancelEmployeeReleaseApi
        
        Alamofire.request(.POST, url, parameters: postParameters).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
}