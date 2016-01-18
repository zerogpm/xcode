//
//  GistRouter.swift
//  RestApiToTableView
//
//  Created by Jian Su on 1/16/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation
import Alamofire

enum GistRouter: URLRequestConvertible {
    static let baseURLString = "https://api.github.com"
    
    case GetPublic()
    
    var URLRequest: NSMutableURLRequest {
        var method: Alamofire.Method {
            switch self {
            case .GetPublic:
                return .GET
            }
        }
        
        let result: (path: String, parameters: [String: AnyObject]?) = {
            switch self {
            case .GetPublic:
                return ("/gists/public", nil)
            }
        }()
        
        let URL = NSURL(string: GistRouter.baseURLString)!
        print(result)
        let URLRequest = NSURLRequest(URL: URL.URLByAppendingPathComponent(result.path))
        
        let encoding = Alamofire.ParameterEncoding.JSON
        let (encoded, _) = encoding.encode(URLRequest, parameters: result.parameters)
        
        encoded.HTTPMethod = method.rawValue
        
        return encoded
    }
}
