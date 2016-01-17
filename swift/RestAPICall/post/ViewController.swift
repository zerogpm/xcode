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
    
        Alamofire.request(PostRouter.GetAll()).responseJSON { response in
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
//
//        // MARK: Get Post #1
//        Post.postByID(1, completionHandler: { result in
//          if let error = result.error {
//            // got an error in getting the data, need to handle it
//            print("error calling POST on /posts")
//            print(error)
//            return
//        }
//        guard let post = result.value else {
//            print("error calling POST on /posts: result is nil")
//            return
//        }
//        // success!
//            print(post.description())
//            if let title = post.title , body = post.body {
//                printTitle(title, body: body)
//            }
//        })
    }

}

