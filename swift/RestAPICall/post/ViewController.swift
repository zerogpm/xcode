//
//  ViewController.swift
//  post
//
//  Created by Chris Su on 2016-01-14.
//  Copyright © 2016 PushOperations. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let postEndpoint: String = "http://api.chrissu.design/api/v1/lesson"
        Alamofire.request(.GET, postEndpoint).responseJSON { response in
            guard response.result.error == nil else {
                print("error calling GET on /posts/1")
                print(response.result.error!)
                return
            }
            
            if let value: AnyObject = response.result.value {
                let post = JSON(value)
                print("The post is: " + post.description)
                if let title = post["data"][0]["title"].string {
                    print("The title is: \(title)")
                } else {
                    print("error pasing")
                }
            }
            
        }
        
//        let newPost = ["title":"Lua", "body": "gaming language", "confirmed" : 0]
//        Alamofire.request(.POST, postEndpoint, parameters:newPost)
//            .responseJSON { response in
//                guard response.result.error == nil else {
//                    print("error calling from Post")
//                    print(response.result.error!)
//                    return
//                }
//                
//                if let value: AnyObject = response.result.value {
//                    let post = JSON(value)
//                    print("The value is: \(post.description)")
//                }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

