//
//  ViewController.swift
//  CalculatorSimple
//
//  Created by Jian Su on 2015-08-25.
//  Copyright (c) 2015 Jian Su. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var total:Int = 0
    var mode:Int = 0
    var valueString:String! = ""
    var lastButtonWasMode:Bool = false
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedNumber(sender: UIButton) {
    }
    
    @IBAction func tappedPlus(sender: AnyObject) {
    }
    
    @IBAction func tappedMinu(sender: AnyObject) {
    }
    
    
    @IBAction func tappedMutple(sender: AnyObject) {
    }
    
    
    @IBAction func tappedEqual(sender: AnyObject) {
    }
    
    
    @IBAction func tappedClear(sender: AnyObject) {
    }
    
    func MySetMode(m:Int) {
        
    }


}

