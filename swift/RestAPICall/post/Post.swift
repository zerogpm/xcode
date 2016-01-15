//
//  Post.swift
//  post
//
//  Created by Chris Su on 2016-01-14.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Post {
    var title:String?
    var body:String?
    
    required init?(aTitle:String?, aBody:String?) {
        self.title = aTitle
        self.body = aBody
    }
    
    func description() -> String {
        return "title: \(self.title)" +
        "Body: \(self.body)"
    }
    
    func toJSON() -> Dictionary<String, AnyObject> {
        var json = Dictionary<String, AnyObject>()
        if let title = title {
            json["title"] = title
        }
        if let body = body {
            json["body"] = body
        }
        return json
    }
    
}