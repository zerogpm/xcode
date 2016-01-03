//
//  ViewController.swift
//  PostManRequest
//
//  Created by Jian Su on 1/2/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let urlString = "http://swapi.co/api/people/1/"
        let url = NSURL(string:urlString)!
        let session = NSURLSession.sharedSession()
        session.dataTaskWithURL(url) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if let responseData = data {
                do {
                   
                   /**
                    you need to set plist in order for non https to work. add the following

                    App Transport Security Settings : Dictionary
                     |
                     |-->Allow Arbitrary Loads Boolean: YES
                    **/
                    
                   let json = try NSJSONSerialization.JSONObjectWithData(responseData, options: NSJSONReadingOptions.AllowFragments)
                   print(json)
                } catch {
                    print("Cannot serialization")
                }
            }
        }.resume()
    }


}

