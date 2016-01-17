//
//  GitHubAPIManager.swift
//  RestApiToTableView
//
//  Created by Jian Su on 1/16/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import Foundation
import Foundation
import Alamofire
import SwiftyJSON

class GitHubAPIManager {
    static let sharedInstance = GitHubAPIManager()
    
    func printPublicGists() -> Void {
        Alamofire.request(GistRouter.GetPublic())
          .responseString { response in
            if let receivedString = response.result.value {
                print(receivedString)
            }//end of if statment
        }// end of responseString
    }// end of printPubliceGists function
}