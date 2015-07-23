//
//  ViewController.swift
//  CatYear
//
//  Created by Jian Su on 3/9/15.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ageText: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBAction func findAge(sender: AnyObject) {
        var catAge : Int;
        let numberAge = ageText.text.toInt()
        
        if numberAge != nil {
            catAge = 7 * numberAge!
            message.text = "your Cat are likey to live in \(catAge)"
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

