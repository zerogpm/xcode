//
//  PickUpPostModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-04-18.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PickUpPostModel {
    
    var userChangeApproved :String = ""
    var releaseId :String = ""
    var userId: String = ""
    
    init(userId:String, releaseId:String, userChangeApproved:String) {
        self.userId = userId
        self.releaseId = releaseId
        self.userChangeApproved = userChangeApproved
    }
    
    func shiftRelease(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let postParameters: [String:String] = [
            "employee_id": self.userId,
            "release_schedule_id" : self.releaseId,
            ]
        
        var url = ""
        if(self.userChangeApproved == PickupShift) {
            url = pickUpshiftApi
        } else {
            url = cancelPickUpshiftApi
        }
        
        Alamofire.request(.POST, url, parameters: postParameters)
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