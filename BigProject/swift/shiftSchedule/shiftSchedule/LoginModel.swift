//
//  LoginModel.swift
//  shiftSchedule
//
//  Created by Chris Su on 2016-03-30.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class LoginModel: NSObject {
    
    var userName:String = ""
    var password:String = ""
    
    init(textUserName:String, textPassword:String) {
        self.userName = textUserName
        self.password = textPassword
    }

    func getLogin(completionHandler: (NSDictionary?, NSError?) -> ()) {
        let loginDic: [String:String] = [
            "userName": self.userName,
            "passWord" : self.password,
            ]
        
        Alamofire.request(.POST, LoginURL, parameters: loginDic)
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
