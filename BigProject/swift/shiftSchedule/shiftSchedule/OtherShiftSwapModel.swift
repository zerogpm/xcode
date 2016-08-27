//
//  OtherShiftSwapModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-20.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol OtherShiftSwapModelDelegate {
    func dataReady()
}

class OtherShiftSwapModel {
    var otherReleaseRequest = [OtherShiftSwap]()
    var delegate:OtherShiftSwapModelDelegate?

    func getOtherEmployeeSwap(id:String, myCompanyId:String) {
        
        var tempeOtherSwapRequest = [OtherShiftSwap]()
        let url = getMySwapShiftApi + "?id=\(id)&companyId=\(myCompanyId)&shiftType=\(otherSwap)"
        
        Alamofire.request(.GET, url).validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    
                    for(_, shift) in json {
                        let shiftSwapObject = OtherShiftSwap()
                        
                        if let releaseID = shift["releaseID"].int {
                            shiftSwapObject.releaseID = String(releaseID)
                        } else {
                            shiftSwapObject.releaseID = "No Data"
                        }
                        
                        if let swapPersonFullName = shift["swapPersonFullName"].string {
                            shiftSwapObject.swapPersonFullName = swapPersonFullName
                        } else {
                            shiftSwapObject.swapPersonFullName = "No Data"
                        }
                        
                        if let swapPerosnScheduledStart = shift["swapPerosnScheduledStart"].string {
                            shiftSwapObject.swapPerosnScheduledStart = swapPerosnScheduledStart
                        } else {
                            shiftSwapObject.swapPerosnScheduledStart = "No Data"
                        }
                        
                        if let swapPersonTimeRange = shift["swapPersonTimeRange"].string {
                            shiftSwapObject.swapPersonTimeRange = swapPersonTimeRange
                        } else {
                            shiftSwapObject.swapPersonTimeRange = "No Data"
                        }
                        
                        if let myScheduledStart = shift["myScheduledStart"].string {
                            shiftSwapObject.myScheduledStart = myScheduledStart
                        } else {
                            shiftSwapObject.myScheduledStart = "No Data"
                        }
                        
                        if let myTimeRange = shift["myTimeRange"].string {
                            shiftSwapObject.myTimeRange = myTimeRange
                        } else {
                            shiftSwapObject.myTimeRange = "No Data"
                        }
                        
                        if let status = shift["shiftStatus"].string {
                            shiftSwapObject.shiftStatus = status
                        } else {
                            shiftSwapObject.myTimeRange = "No Data"
                        }
                        
                        if let swapPersonPosition = shift["swapPersonPosition"].string {
                            shiftSwapObject.swapPersonPosition = swapPersonPosition
                        } else {
                            shiftSwapObject.swapPersonPosition = "No Data"
                        }
                        
                        if let myPosition = shift["myPosition"].string {
                            shiftSwapObject.myPosition = myPosition
                        } else {
                            shiftSwapObject.myPosition = "No Data"
                        }
                        
                        tempeOtherSwapRequest.append(shiftSwapObject)
                    }
                    self.otherReleaseRequest = tempeOtherSwapRequest
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