//
//  Gist.swift
//  RestApiToTableView
//
//  Created by Jian Su on 1/16/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation
import SwiftyJSON

class Gist {
    var id: String?
    var description: String?
    var ownerLogin: String?
    var onwerAvatarURL: String?
    var url: String?
    
    required init(json:JSON) {
        self.id = json["id"].string
        self.description = json["description"].string
        self.ownerLogin = json["owner"]["login"].string
        self.onwerAvatarURL = json["owner"]["avatar_url"].string
        self.url = json["url"].string
    }
    
    required init() {
        
    }
}
