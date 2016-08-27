//
//  EmployeeSwapModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-20.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol EmployeeSwapModelDelegate {
    func dataReady()
}

class EmployeeSwapModel {
    
    var employeeSwapRequestList = [shiftSwap]()
    var delegate:EmployeeSwapModelDelegate?
    
    func getEmployeeSwapRequest(id:String, myCompanyId:String) {
        
        var tempEmployeeSwapRequestObjects = [shiftSwap]()
        let url = getMySwapShiftApi + "?id=\(id)&companyId=\(myCompanyId)"
        print(url)
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    for(_, scheduler) in json {
                        let employeeSwapRequestObject = shiftSwap()
                        
                        if let releaseID = scheduler["releaseID"].int {
                            employeeSwapRequestObject.releaseID = String(releaseID)
                        } else {
                            employeeSwapRequestObject.releaseID = "No Data"
                        }
                        
                        if let myScheduledStart = scheduler["myScheduledStart"].string {
                            employeeSwapRequestObject.myScheduledStart = myScheduledStart
                        } else {
                            employeeSwapRequestObject.myScheduledStart = "No Data"
                        }
                        
                        if let myTimeRange = scheduler["myTimeRange"].string {
                            employeeSwapRequestObject.myTimeRange = myTimeRange
                        } else {
                            employeeSwapRequestObject.myTimeRange = "No Data"
                        }
                        
                        if let swapPersonFullName = scheduler["swapPersonFullName"].string {
                            employeeSwapRequestObject.swapPersonFullName = swapPersonFullName
                        } else {
                            employeeSwapRequestObject.swapPersonFullName = "No Data"
                        }
                        
                        if let swapPerosnScheduledStart = scheduler["swapPerosnScheduledStart"].string {
                            employeeSwapRequestObject.swapPerosnScheduledStart = swapPerosnScheduledStart
                        } else {
                            employeeSwapRequestObject.swapPerosnScheduledStart = "No Data"
                        }
                        
                        if let swapPersonTimeRange = scheduler["swapPersonTimeRange"].string {
                            employeeSwapRequestObject.swapPersonTimeRange = swapPersonTimeRange
                        } else {
                            employeeSwapRequestObject.swapPersonTimeRange = "No Data"
                        }
                        
                        if let swapPersonPosition = scheduler["swapPersonPosition"].string {
                            employeeSwapRequestObject.swapPersonPosition = swapPersonPosition
                        } else {
                            employeeSwapRequestObject.swapPersonPosition = "No Data"
                        }
                        
                        if let myPosition = scheduler["myPosition"].string {
                            employeeSwapRequestObject.myPosition = myPosition
                        } else {
                            employeeSwapRequestObject.myPosition = "No Data"
                        }
                        
                        tempEmployeeSwapRequestObjects.append(employeeSwapRequestObject)
                    }
                    self.employeeSwapRequestList = tempEmployeeSwapRequestObjects
                    
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
    
    
    func deleteMySwap(currentShiftId:String) {
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