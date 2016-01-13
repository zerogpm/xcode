//
//  OpeningData.swift
//  FreshSlicePizza
//
//  Created by Chris Su on 2016-01-11.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import Foundation
import Alamofire

class OpeningData {
    
    private var _description: String
    private var _completed = false
    private var _resourceUrl: String!
    
    var description: String {
        return self._description
    }
    
    var completed:Bool {
        set {
            self._completed = newValue
        }
        get {
            return self._completed
        }
    }
    
    init(description: String, completed: Bool) {
        self._description = description
        self._completed = completed
        self._resourceUrl = "\(URL_BASE)\(URL_POKEMON)"
    }
    
    func downloadOpeningDetail(completed: DownloadComplete) {
        let url = NSURL(string: self._resourceUrl)!
        Alamofire.request(.GET, url).responseJSON {
            response in let result = response.result
            print(result.value.debugDescription)
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let description = dict["species"] as? String {
                    self._description = "\(description)"
                }
            }
            completed()
        }
    }
    
}