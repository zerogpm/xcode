//
//  ShiftReleaseModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-15.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol ShiftReleaseModelDelegate {
    func dataReady()
}

class ShiftReleaseModel {
    var otherReleaseRequest = [OtherReleaseRequest]()
    var delegate:ShiftReleaseModelDelegate?
    
    func getMyShiftRelease(id:String, myCompanyId:String) {
        
        var tempeOtherReleaseRequest = [OtherReleaseRequest]()
        let url = getReleaseShiftApi + "?id=\(id)&companyId=\(myCompanyId)&shiftType=\(otherShift)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                
                    for(_, shiftRelease) in json {
                        let shiftReleaseObject = OtherReleaseRequest()
                        
                        if let releaseId = shiftRelease["releaseID"].int {
                            shiftReleaseObject.releaseId = String(releaseId)
                        } else {
                            shiftReleaseObject.releaseId = "No Data"
                        }
                        
                        if let fullName = shiftRelease["fullName"].string {
                            shiftReleaseObject.fullName = fullName
                        } else {
                            shiftReleaseObject.fullName = "No Data"
                        }
                        
                        if let scheduledStart = shiftRelease["scheduledStart"].string {
                            shiftReleaseObject.scheduledStart = scheduledStart
                        } else {
                            shiftReleaseObject.scheduledStart = "No Data"
                        }
                        
                        if let timeRange = shiftRelease["timeRange"].string {
                            shiftReleaseObject.timeRange = timeRange
                        } else {
                            shiftReleaseObject.timeRange = "No Data"
                        }
                        
                        if let position = shiftRelease["position"].string {
                            shiftReleaseObject.position = position
                        } else {
                            shiftReleaseObject.position = "No Data"
                        }
                        
                        if let userChangeApproved = shiftRelease["userChangeApproved"].int {
                            shiftReleaseObject.userChangeApproved = String(userChangeApproved)
                        } else {
                            shiftReleaseObject.userChangeApproved = "No Data"
                        }

                        tempeOtherReleaseRequest.append(shiftReleaseObject)
                    }
                    self.otherReleaseRequest = tempeOtherReleaseRequest
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