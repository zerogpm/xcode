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

final class Post: ResponseJSONObjectSerializable {
    var title:String?
    var body:String?
    
    required init?(aTitle:String?, aBody:String?) {
        self.title = aTitle
        self.body = aBody
    }
    
    required init?(json: SwiftyJSON.JSON) {
        self.title = json["data"]["title"].string
        self.body = json["data"]["body"].string
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
    
    // MARK: API Calls
    class func GetAll(completionHandler: (Result<Post, NSError>) -> Void) {
        Alamofire.request(PostRouter.GetAll())
            .responseObject { (response: Response<Post, NSError>) in
                completionHandler(response.result)
        }
    }
    
    class func postByID(id: Int, completionHandler: (Result<Post, NSError>) -> Void) {
        Alamofire.request(PostRouter.Get(id))
            .responseObject { (response: Response<Post, NSError>) in
                completionHandler(response.result)
        }
    }
    
    // POST / Create
    func save(completionHandler: (Result<Post, NSError>) -> Void) {
        guard let fields:Dictionary<String, AnyObject> = self.toJSON() else {
            print("error: error converting newPost fields to JSON")
            return
        }
        Alamofire.request(PostRouter.Create(fields))
            .responseObject { (response: Response<Post, NSError>) in
                completionHandler(response.result)
        }
    }
}