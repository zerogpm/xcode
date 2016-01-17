//
//  PostRouter.swift
//  post
//
//  Created by Chris Su on 2016-01-14.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire

enum PostRouter: URLRequestConvertible {
    static let baseURLString = "http://api.chrissu.design/api/v1/"
    
    case Get(Int)
    case GetAll()
    case Create([String: AnyObject])
    case Delete(Int)
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .Get:
                return .GET
            case .GetAll:
                return .GET
            case .Create:
                return .POST
            case .Delete:
                return .DELETE
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .Get(let postNumber):
                return ("lesson/\(postNumber)", nil)
            case .GetAll():
                return ("lesson", nil)
            case .Create(let newPost):
                return ("lesson", newPost)
            case .Delete(let postNumber):
                return ("lesson/\(postNumber)", nil)
            }
        }()
        
        let URL = NSURL(string: PostRouter.baseURLString)!
        print(result)
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encoded, _) = encoding.encode(URLRequest, parameters: result.parameters)
        
        encoded.HTTPMethod = method.rawValue
        
        return encoded
    }
}