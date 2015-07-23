//
//  ViewController.swift
//  HowMayFingers
//
//  Created by Jian Su on 3/10/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var input: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBAction func findOutBtn(sender: AnyObject) {
        var randomNum = Int(arc4random_uniform(10))
        
        if input.text.toInt() != nil {
            if input.text.toInt() == randomNum {
                message.text = "Right on!"
                input.resignFirstResponder()
            }else {
                message.text = "Wrong try again"
                input.resignFirstResponder()
            }
            
        } else {
            message.text = "Wrong value"
        }
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

