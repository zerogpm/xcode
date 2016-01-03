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
                   
                    if let dict = json as? Dictionary<String, AnyObject> {
                        if let name = dict["name"] as? String, let heigh = dict["height"] as? String, let brith = dict["birth_year"] as? String , let hairColor = dict["hair_color"] as? String {
                            let SWPerson = Person(name: name, heigh: heigh, birthYear: brith, hairColor: hairColor)
                            print(SWPerson.name)
                            
                            if let films = dict["films"] as? [String] {
                                for film in films {
                                    print(film)
                                }
                            }
                        }
                    }
                    
                   //print(json)
                } catch {
                    print("Cannot serialization")
                }
            }
        }.resume()
    }


}

