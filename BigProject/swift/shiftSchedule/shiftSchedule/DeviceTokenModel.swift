//
//  DeviceTokenModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-05-09.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class DeviceTokenModel: NSObject {
    
    var userId:String = ""
    var deviceToken:String = ""
    
    init(userId:String, deviceToken:String) {
        self.userId = userId
        self.deviceToken = deviceToken
    }
    
    func saveDeviceToken(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let deviceParameters: [String:String] = [
            "user_id": self.userId,
            "deviceToken" : self.deviceToken,
            ]

        Alamofire.request(.POST, deviceSaveApi, parameters: deviceParameters)
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