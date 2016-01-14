//
//  ViewController.swift
//  testing
//
//  Created by Jian Su on 1/13/16.
//  Copyright © 2016 Jian Su. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
        Alamofire.request(.GET, "http://swapi.co/api/people/1").validate().responseJSON { response in
            switch response.result {
            case .Success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json["name"].string)
                    print(json["films"].arrayValue)
                    print(json["films"][0].stringValue)
                }
            case .Failure(let error):
                print(error)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

