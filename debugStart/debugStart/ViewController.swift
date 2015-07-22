//
//  ViewController.swift
//  debugStart
//
//  Created by Jian Su on 2/22/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    
    @IBAction func performCalucation(sender: AnyObject) {
        
        var firstVal = calucationFirstValue()
        var secondval = calucationSecond()
        
        resultLabel.text = "The result is \(firstVal / secondval)"
    }
    
    func calucationFirstValue() ->Int {
        return 10000
    }
    
    func calucationSecond() ->Int {
        //This code is intentionally buggy
        var importantNum = calucationFirstValue()
        var unimportanNum = 0
        
        for i in 0...5000 {
            importantNum--
        }
        
        return unimportanNum
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

