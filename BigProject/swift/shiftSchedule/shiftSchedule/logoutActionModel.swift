//
//  logoutActionModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-05-17.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class logoutActionModel: NSObject{
    
    var employeeId : String = ""
    
    init(employeeId:String) {
        self.employeeId = employeeId
    }
    
    func deleteDeviceToken(completionHandler: (NSDictionary?, NSError?) -> ()) {
        
        let deviceParameters: [String:String] = [
            "user_id": self.employeeId,
            ]
        
        Alamofire.request(.POST, deviceLogoutApi, parameters: deviceParameters)
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