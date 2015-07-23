//
//  ViewController.swift
//  PersistentStorage
//
//  Created by Jian Su on 3/29/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //NSUserDefaults.standardUserDefaults().setObject("Chris", forKey: "name")

        var name = NSUserDefaults.standardUserDefaults().objectForKey("name") as String
        println(name)
        
        var arr = [0,2,3]
        //NSUserDefaults.standardUserDefaults().setObject(arr, forKey: "array")
        var recallArray = NSUserDefaults.standardUserDefaults().objectForKey("array") as NSArray
        println(recallArray[2])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

